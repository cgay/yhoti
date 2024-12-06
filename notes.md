# Brainstorming about Yhoti

## Latest thoughts

### Apps platform?

Perhaps change my thinking about Yhoti, towards being a plug-in architecture. Got this
idea from Softaculous, which appears to be a PHP-based app platform. Take a look at how
developing an app for Softaculous works. Not sure but maybe this?:
https://www.softaculous.com/docs/developers/making-custom-package/

### Mail is another big data privacy area

So it should support a self-hosted email solution.

## Elevator Pitch (it's a slow elevator in a tall building)

Yhoti is "Your Home On The Internet", a place where you can easily create and share
content with as few or as many people as you like, and you own all the data.

* Express yourself

  A place where you can share your blog, share photos, post items for sale, send and
  receive email, and have conversations with your family and friends (or the entire
  internet).

* You control your own data

  Go low-tech and periodically back up to a thumb drive in your basement or store
  encrypted data in the cloud hosting service of your choice.

* You control access

  You control who can or can't contribute to the conversation, from fully public to only
  allow-listed individuals. You can remove any unwanted comments or contributions from
  others.

* No algorithm

  There is no "algorithm" pushing obnoxious user content or ads to you. (There is also
  nothing preventing you from putting ads on your site if you want to.)

* Not a competition

  It's not about trying to get the most friends or the most "likes" for your content,
  it's about having a place to express yourself. Yes, people can still "like" your
  content (free dopamine!), but because there is no algorithm pushing this information to
  all your friends it's not a competition.

* Easy to install and run

  It is absolutely trivial to get up and running. Choose from a menu of features to
  enable, with reasonable default settings. Friends can login with their Facebook or
  Google account or create a local account. (Google, fb, logins have tracking
  implications, so there's a trade-off here.)

* Flexible

  There is one instance per person, or per family, or per organization. Turn major
  features on/off with ease. It's up to you!

* Interconnected (but not monolithic)

  Each Yhoti instance automatically provides links to other Yhotis that the maintainers
  reference or explicitly recommend.  These references can be organized by topic and show
  recent activity on the target Yhotis.

* Open source

  All the code can be improved and audited by anyone.

Yhoti returns us to the early promise of the Internet, where **your eyeballs are not the
product, making billionaires ever richer through ads** but rather where you can express
yourself freely and creatively! The whole point of the Web is that you don't need to put
your content into one centralized system like Facebook or Twitter because anyone can make
their own site.

Yhoti is born from a realization that centralized social media isn't working; it's toxic
because The Algorithm pushes content that generates the most heat.  But Yhoti also
acknowledges that we want to connect with people far away from us.  Yhoti shows you
recent activity on your friends' Yhotis (think RSS here). "Rowan wrote a new blog post."
"There's been chat activity at Lulu's place." Rather than doom scrolling through every
post made by every friend, you choose which friends to visit.


## Major Features

* Arbitrary web pages, blog support, chat support, simple photo albums.
* Ease of use is key
  - Minimal tech knowledge required.
  - Trivial initial setup with basic features.
  - Create content via web UI. (basic)
  - Create content by editing Markdown or other semi-technical formats.
* Pervasive features
  - All content has an ID to reference in links.
  - All content has arbitrary tags for organization and searchability.
  - Pluggable themes.
  - Search, respecting ACLs (below).
* Accounts / Authentication
  - Site owner must be able to review each user's email address (or full name?).
  - Option to make it invite only.
  - Users can choose a public name, but owner can always see full ID. (Assumes
    ID = email address?)
* Access Controls
  - Allow list / block list for specific users.
  - Restrict viewing of or contributing to specfic areas. (e.g. user X can view
    blog but can't comment or chat)
  - Restrict viewing content with a specific ID.
  - Contribution rate limits.
  - Trusted contributors list. Needs thought -- maybe this is enough rather
    than the ability to create arbitrary named authentication groups?
  - Allow / disallow contributing to Blog/Chat/etc without authenticating.
  - Protect against DOS attacks.
* Create web content (blog, photo albums, arbitrary web pages)
  - Just enter text and hit Post.
  - Markdown, reStructured Text, etc.
  - Ability to comment on posts, with or without approval depending on trust level.
* Chat
  - Initially just a single room for friends to stop by and chat.
  - Configurable chat history limits, with / without culling DB storage.
* Storefront
  - List items for sale (or free)
  - Accept payments
* Data Storage
  - Source files (Lisp code, web page templates, ...) stored in Git.
  - Bulk files (binaries, data sets, ...) stored in GitHub, Google Drive, MS,
    Dropbox, etc. and just linked normally.
  - Chat messages and blog comments stored in SQLite?, Redis?. What about blog
    content, which could be longer. It's still generally only a few KB in size.
    Probably should make this pluggable. For small sites it can be useful to
    just store it in files for grepability. Would like to avoid depending on a
    specific db.
* The Yhotiverse
  - Ability to quickly view activity on other Yhotis of interest to you.
  - Ability to recommend other Yhotis, or "here's where you might like to go next". I can
    imagine this being an autogenerated list based on yhoti:// links found on the site,
    showing the ones with recent updates.


## Resources

* Blog (static site) generator: https://github.com/coleslaw-org/coleslaw
* Auth: https://github.com/CodyReichert/awesome-cl?tab=readme-ov-file#user-login-and-password-management
* Chat: https://quickdocs.org/maiden,
* Templating: https://github.com/dlowe-net/stencl
* https://indieweb.org/ https://diasporafoundation.org/ -- Look these over for potential
  prior art and/or ideas.
* https://www.softaculous.com seems worth looking at as a way to develop a self-hosted
  platform of apps. Might get some ideas from it.
* Guile web app framework: https://artanis.dev/ (buzzword compliant)
* Guile static site gen: https://dthompson.us/projects/haunt.html
* Drupal is a CMS to look at. I noticed it because of Universal Hub. Clearly it works for
  blog+accounts+comments but I don't know its scope. (It's in PHP.)
* https://web-apps-in-lisp.github.io/tutorial/getting-started/index.html looks like a
  useful example for CL web apps.
* https://en.wikipedia.org/wiki/Solid_%28web_decentralization_project%29 Solid is a
  project to allow people to retain control over their personal data but still allow
  access to it. Maybe it could be the storage substrate?
* https://immich.app/ self hosted photo albums
* https://en.wikipedia.org/wiki/Comparison_of_software_and_protocols_for_distributed_social_networking
  links to Friendica (dlowe mentioned) and others. Friendica looks superficially very
  similar to what I'm thinking of (but PHP).
* https://github.com/9001/copyparty - "turn almost any device into a file server with
  resumable uploads/downloads" (Chris O)

## Design Thoughts

* Layering
  - yhoti-base -- Utilities applicable to all other layers
    - yhoti-store -- Storage implementation
      - Pluggable back ends, like local files, Google Drive, local Git, etc.
    - yhoti-auth -- Authentication and ACLs

  - "Apps" can be plugged in
    - yhoti-blog -- Blog implementation
    - yhoti-chat -- Chat implementation
    - yhoti-pay  -- Payments implementation
      + accept payments from logged in users
    - yhoti-verse -- Interconnection with other Yhotis.
      + "show me new blog activity no more than once a day"
      + "show me new chat activity no more than once an hour"
      + RSS feed (is there a better way these days?)

  - Ability to generate either a fully static blog/site or use dynamic features,
    depending on needs. Static sites can have benefits from being servable by any web
    server and theoretically can be less hackable. (c.f. Haunt, the Guile static site
    generator which makes this claim.)
