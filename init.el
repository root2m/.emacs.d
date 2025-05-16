;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:


(defvar lmmv/emacs-config-file "EmacsConfig.org"
  "Main Config file, .org or .el.")

(defvar lmmv/emacs-config-tangle-file (concat (file-name-base lmmv/emacs-config-file) ".el")
  "Config file for 'lmmv/emacs-config-file', if it is a org file.")

(defun lmm/emacs-build-config-file(&optional load)
  "Load config file, '.el' or '.org' file."
  (interactive "P")
  (let* ((init-file (expand-file-name  lmmv/emacs-config-tangle-file user-emacs-directory))
         (init-org-file (expand-file-name lmmv/emacs-config-file user-emacs-directory)))
    (cond ((and (numberp load) (> load 4))
           (org-babel-load-file init-org-file))
          (load
           (if (file-exists-p init-file)
               (load-file init-file)
             (org-babel-load-file init-org-file)))
          (t
           (require 'org)
           (org-babel-tangle-file init-org-file init-file)))))

(lmm/emacs-build-config-file 'load)

(add-hook 'kill-emacs-hook #'lmm/emacs-build-config-file)

;; 消除启动提示消息
(fset 'display-startup-echo-area-message 'ignore)
;; 让hook顺序倒过来， 符合EmacsConfig.org配置编写逻辑
(setq after-init-hook (reverse after-init-hook))

(provide 'init)
;;; init.el ends here
