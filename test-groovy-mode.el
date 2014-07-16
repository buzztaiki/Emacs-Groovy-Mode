;;; test-groovy-mode.el --- Tests for groovy-mode.el

;; Copyright (C) 2014  Taiki Sugawara

;; Author: Taiki Sugawara <buzz.taiki@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(require 'ert)

(defun test-groovy-indent-string (str)
  (with-temp-buffer
    (groovy-mode)
    (insert str)
    (indent-region (point-min) (point-max))
    (buffer-substring-no-properties (point-min) (point-max))))

(ert-deftest groovy-indent-named-label-cont-noempty ()
  (should (string= (test-groovy-indent-string
                    "
\[a:b,
c:d,
e:f]")
                   "
\[a:b,
 c:d,
 e:f]")))

(ert-deftest groovy-indent-named-label-cont ()
  (should (string= (test-groovy-indent-string
                    "
\[
a:b,
c:d,
e:f]")
                   "
\[
  a:b,
  c:d,
  e:f]")))

(ert-deftest groovy-indent-statement-after-def ()
  (should (string= (test-groovy-indent-string
                    "
def foo = 10
bar([1,
2])
baz")
                   "
def foo = 10
bar([1,
     2])
baz")))

(provide 'test-groovy-mode)
;;; test-groovy-mode.el ends here
