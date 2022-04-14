;;; package --- summary
;;; Commentary:
;;; Code:


;; use straight package manager.
(setq package-enable-at-startup nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
;; 禁止启动屏幕
(setq inhibit-startup-message t)

(provide 'early-init)
;;; early-init.el ends here
