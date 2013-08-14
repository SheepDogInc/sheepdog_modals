# Appends a spinner to `el` (where el is a vanilla JS DOM object)
# Depends on spin.js
addSpinner = (el) ->
  opts =
    lines: 13 # The number of lines to draw
    length: 6 # The length of each line
    width: 3 # The line thickness
    radius: 8 # The radius of the inner circle
    corners: 1 # Corner roundness (0..1)
    rotate: 0 # The rotation offset
    color: "#000" # #rgb or #rrggbb
    speed: 1 # Rounds per second
    trail: 30 # Afterglow percentage
    shadow: false # Whether to render a shadow
    hwaccel: true # Whether to use hardware acceleration
    className: "spinner" # The CSS class to assign to the spinner
    zIndex: 2e9 # The z-index (defaults to 2000000000)
    top: "auto" # Top position relative to parent in px
    left: "auto" # Left position relative to parent in px

  spinner = new Spinner(opts).spin(el)

# Set the modal html and hook up click-handlers. On form submit, the
# `postCallback` is executed. If the form contains a `#delete-controls` element,
# the form will be submitted to the element's href when the delete controls
# are clicked.
setModalForm = (modal, formUrl, postCallback, html) ->
  modal.html html
  form = modal.find 'form'
  formSubmit = modal.find "input[type='submit']"
  formDelete = modal.find "#delete-controls"
  formSubmit.on "click", (ev) ->
    ev.preventDefault()
    postCallback modal, form, formUrl
  formDelete.on "click", (ev) ->
    ev.preventDefault()
    noConfirm = formDelete.hasClass('no-confirm')
    deleteConfirmed = if noConfirm then true else confirm gettext("Are you sure you want to delete this?")
    if deleteConfirmed
      $.post(formDelete.attr('href'), null, (response) ->
        if response.status is 'success'
          window.location.href = response.url
        else
          location.reload())

# Submits the `modal`'s `form` by one of two methods: if the form contains a
# file, then it is submitted to the action URL specified in the <form> tag.
# If not, the `form` is POSTed via AJAX to the `actionUrl`.
postModalForm = (modal, form, actionUrl) ->
  if (form.hasClass 'no-ajax') or (form.find "input[type=file]").length > 0
    form.submit()
  else
    $.post(actionUrl, form.serialize(), (response) ->
      if response.status is 'success'
        window.location.href = response.url
      else
        setModalForm(modal, actionUrl, postModalForm, response))

($ document).ready ->
  modal = $ "#page-modal"
  modal.modal
    backdrop: 'static'
    show: false
  modal.on "shown", ->
    addSpinner(modal[0])
  modal.on "hidden", -> modal.html ""

  $(".edit-controls, .add-controls").on "click", (ev) ->
    ev.preventDefault();
    modal.modal "show"
    formUrl = ($ this).attr "href"
    $.get formUrl, (response) -> setModalForm(modal, formUrl, postModalForm,
      response)

