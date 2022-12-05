;;; package --- summary
;;; Commentary:
;;; Code:


(setq garbage-collection-messages t
      gc-cons-threshold (* 100 1024 1024)
      gc-cons-percentage 0.6

      default-frame-alist '((width . 200)
                            (height . 50)
                            (left . 100)
                            (top . 50))

      pgtk-wait-for-event-timeout 0.001

      ;; Increase how much is read from processes in a single chunk (default is 4kb)
      read-process-output-max (* 4 1024 1024)

      package-enable-at-startup nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
;; 禁止启动屏幕
(setq inhibit-startup-message t)

(provide 'early-init)
;;; early-init.el ends here
