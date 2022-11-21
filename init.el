;;; init.el --- Load the full configuration
;;; Commentary:

;;; Code:


(defvar lmmv/emacs-in-wsl (file-exists-p "/mnt/wsl")
  "Emacs if run wsl, is t else nil.")

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

(defun lmm/emacs-load-user-config()
  "Load config file, '.el' or '.org' file."
  (interactive)
  (let* ((init-file (expand-file-name  lmmv/emacs-config-tangle-file user-emacs-directory))
         (init-org-file (expand-file-name lmmv/emacs-config-file user-emacs-directory)))
    (if (file-exists-p init-file)
        (load-file init-file)
      (if (file-exists-p init-org-file)
          (org-babel-load-file init-org-file)
        (display-warning :warning (format "File %s not exitsed!!!" init-org-file))))))

(lmm/emacs-load-user-config)

(defun lmm/emacs-build-config-file()
  "Build config file for org, add to 'kill-emacs-hook'."
  (interactive)
  (let* ((init-file (expand-file-name  lmmv/emacs-config-tangle-file user-emacs-directory))
         (init-org-file (expand-file-name lmmv/emacs-config-file user-emacs-directory)))
    (when (file-exists-p init-org-file)
      (org-babel-tangle-file init-org-file init-file))))

(add-hook 'kill-emacs-hook #'lmm/emacs-build-config-file)

;; 消除启动提示消息
(fset 'display-startup-echo-area-message 'ignore)
;; 让hook顺序倒过来， 符合EmacsConfig.org配置编写逻辑
(setq after-init-hook (reverse after-init-hook))

(provide 'init)
;;; init.el ends here
