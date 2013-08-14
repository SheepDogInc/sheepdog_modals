Sheepdog Modals
===============

Sheepdog Modals provides HTML templates, CoffeeScript, and the ModalViewMixin
class to facilitate the usage of modals in a web application. The included
resources allow a modal to view, create, edit, or delete via AJAX.

An engineer is able to bypass the default success_url that results from the AJAX
request by specifying a class as 'no-ajax'. If this is done, then the view tied
to the modal can provide its own success_url and redirect as expected.

To use Sheepdog Modals, have your modal file inherit from one of 'modal_form',
'modal_add', 'modal_edit', or 'modal_delete'. To launch the modal, include the class 
'add-controls' or 'edit-controls' in the element responsible for the modal. 

Example:

```html
<a class="btn add-controls" href="{% url "modal_url" %}"><i class="icon-ok"></i> {% trans "Button Text" %}</a>
```
