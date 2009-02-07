Blog
====

Simple blog facility, with approvable comment facility

Please see TODO file for planned work.

Usage
-----

Administrator writes a blog entry in Html via admin interface

S/he can embed product details by including skus in *...*, eg "*00120*"
These expanded inline into link to product and a corresponding small
image is added after the blog text. 

/the-blog/ (or blog_entries_path) then shows the entries in decreasing date order


Users can read the comments attached to an entry, and logged-in users can 
submit plain text comments with an optional page link. 

Only admin-approved comments are shown.  Administrators can approve and/or 
edit comments.


In addition to the usual new/create/index actions, there's a partial
"_blog_snippet" for showing the most recent N blog entry titles.



Implementation
--------------

I might rename "blog_entry" to just "blog" - unless there's a proper word for
an entry in a blog! Suggestions on a postcard...



