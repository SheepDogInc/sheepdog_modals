Sheepdog Modals
===============

Sheepdog Modals provides HTML templates, CoffeeScript, and the ModalViewMixin
class to facilitate the usage of modals on a web application. The included
resources allow a modal to view, create, edit, or delete via AJAX.

modal-forms.coffee allows an engineer to bypass the default success_url that
results from the AJAX request by specifying a class as 'no-ajax'. If this is
done, then the view tied to the modal can provide its own success_url and
redirect as expected.
