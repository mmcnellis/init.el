(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Kill the current buffer immediatly, saving it if needed.
(defvar kill-save-buffer-delete-windows t
    "*Delete windows when `kill-save-buffer' is used.
If this is non-nil, then `kill-save-buffer' will also delete the corresponding
windows.  This is inverted by `kill-save-buffer' when called with a prefix.")
(defun kill-save-buffer (arg)
    "Save the current buffer (if needed) and then kill it.
Also, delete its windows according to `kill-save-buffer-delete-windows'.
A prefix argument ARG reverses this behavior."
    (interactive "P")
    (let ((del kill-save-buffer-delete-windows))
      (when arg (setq del (not del)))
      (when (and (buffer-file-name) (not (file-directory-p (buffer-file-name))))
	(save-buffer))
      (let ((buf (current-buffer)))
	(when del (delete-windows-on buf))
	      (kill-buffer buf))))

(global-set-key (kbd "C-x k") 'kill-save-buffer)

;; Bind magit status to C-c g
(global-set-key (kbd "C-x k") 'kill-save-buffer)
(global-set-key (kbd "C-c g") 'magit-status)
