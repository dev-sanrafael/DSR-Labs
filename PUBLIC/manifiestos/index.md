---
layout: default
title: Manifiestos DSR Labs
---

# Manifiestos DSR Labs

{% raw %}{% assign files = site.static_files | where: "path", "/DSR-Labs/PUBLIC/manifiestos" %}{% endraw %}
{% raw %}{% for file in site.static_files %}{% endraw %}
{% raw %}{% if file.path contains "/PUBLIC/manifiestos/" and file.extname == ".md" and file.name != "index.md" %}{% endraw %}
- [{{ file.name | replace: "_", " " | replace: ".md", "" }}]({{ file.name }})
{% raw %}{% endif %}{% endraw %}
{% raw %}{% endfor %}{% endraw %}