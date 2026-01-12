;; extends

(element
  (start_tag
    (tag_name) @_tag)
  (#match? @_tag "^h[1-6]$")) @heading.outer
