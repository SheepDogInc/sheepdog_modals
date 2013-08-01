import json
from django.core.exceptions import ImproperlyConfigured
from django.http import HttpResponse


class ModalViewMixin(object):

    """
    Generates AJAX-specific responses when mixed with views intended to be
    displayed in modals. If the request is not via AJAX, the mixin delegates
    responsibility to its super.

    Supports: delete() (with DeleteView) and form_valid() (UpdateView)
    """
    def delete(self, request, *args, **kwargs):
        if not hasattr(super(ModalViewMixin, self), 'delete'):
            raise ImproperlyConfigured(
                'To call delete(), ModalViewMixin must be mixed with a view'
                'that supports delete()'
            )

        default_response = super(
            ModalViewMixin, self).delete(request, *args, **kwargs)
        if self.request.is_ajax():
            response_json = json.dumps({
                'status': 'success',
                'url': self.get_success_url()
            })
            return HttpResponse(response_json, mimetype='application/json')
        else:
            return default_response

    def form_valid(self, form):
        if not hasattr(super(ModalViewMixin, self), 'form_valid'):
            raise ImproperlyConfigured(
                'To call form_valid(), ModalViewMixin must be mixed with a'
                ' view that supports form_valid()'
            )

        default_response = super(ModalViewMixin, self).form_valid(form)
        if self.request.is_ajax():
            return HttpResponse(
                json.dumps({'status': 'success'}),
                mimetype='application/json')
        else:
            return default_response
