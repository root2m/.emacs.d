;;; init.el --- Load the full configuration
;;; Commentary:

;;; Code:




(when (or (string-search "WSL" operating-system-release) (string-search "wsl" operating-system-release))
  (setenv "PATH" "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl")
  (setq exec-path (split-string "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl" path-separator)))


(org-babel-load-file
 (expand-file-name
  "EmacsConfig.org"
  user-emacs-directory))

;; 让hook顺序倒过来， 符合EmacsConfig.org配置编写逻辑
(setq after-init-hook (reverse after-init-hook))

(provide 'init)
;;; init.el ends here
