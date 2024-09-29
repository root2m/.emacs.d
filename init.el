;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:


(defvar lmmv/emacs-in-wsl (file-exists-p "/mnt/wsl")
  "Emacs if run wsl, is t else nil.")

(defvar lmmv/emacs-nox-p (string-match "--with-x=no" system-configuration-options nil t)
  "Emacs if no x, is t else nil.")

(when lmmv/emacs-in-wsl
  (let ((path (replace-regexp-in-string "/mnt[^:]*:?" "" (getenv "PATH"))))
    (setenv "PATH" path)
    (setq exec-path (split-string path ":"))
    (setq browse-url-browser-function (lambda(url &rest args)
                                        (start-process
                                         (concat "WinExplorer " url)
                                         nil
                                         "/mnt/c/Windows/explorer.exe"
                                         url)))))

(defvar lmmv/emacs-config-file "EmacsConfig.org"
  "Main Config file, .org or .el.")

(defvar lmmv/emacs-config-tangle-file (concat (file-name-base lmmv/emacs-config-file) ".el")
  "Config file for 'lmmv/emacs-config-file', if it is a org file.")

(defun lmm/emacs-build-config-file(&optional load)
  "Load config file, '.el' or '.org' file."
  (interactive "P")
  (let* ((init-file (expand-file-name  lmmv/emacs-config-tangle-file user-emacs-directory))
         (init-org-file (expand-file-name lmmv/emacs-config-file user-emacs-directory))
         (fun (make-symbol "lmm/org-babel-get-src-block-info-change")))
    (when lmmv/emacs-nox-p
      (fset fun (lambda (info)
                  (when info
                    (if (assq :nox (nth 2 info))
                        (setf (cdr (assq :tangle (nth 2 info))) init-file)
                      (setf (cdr (assq :tangle (nth 2 info))) "no")))
                  info))
      (advice-add 'org-babel-get-src-block-info :filter-return fun))
    (cond ((and (numberp load) (> load 4))
           (org-babel-load-file init-org-file))
          (load
           (if (file-exists-p init-file)
               (load-file init-file)
             (org-babel-load-file init-org-file)))
          (t
           (require 'org)
           (org-babel-tangle-file init-org-file init-file)))
    (when lmmv/emacs-nox-p
      (advice-remove 'org-babel-get-src-block-info fun))))

(lmm/emacs-build-config-file 'load)

(add-hook 'kill-emacs-hook #'lmm/emacs-build-config-file)

;; 消除启动提示消息
(fset 'display-startup-echo-area-message 'ignore)
;; 让hook顺序倒过来， 符合EmacsConfig.org配置编写逻辑
(setq after-init-hook (reverse after-init-hook))

(provide 'init)
;;; init.el ends here
