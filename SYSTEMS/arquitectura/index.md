---
layout: default
title: Arquitectura DSR Labs
---

# Arquitectura DSR Labs

{% for page in site.pages %}
  {% if page.path contains "SYSTEMS/arquitectura/"
        and page.name != "index.md" %}
- [{{ page.title | default: page.name | replace: "_", " " }}](/DSR-Labs{{ page.url | remove: '.html' }})
  {% endif %}
{% endfor %}
