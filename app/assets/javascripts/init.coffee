
  $ ->
    $('#login').on 'shown.bs.modal', ()->
      $(this).find("[autofocus]:first").focus()
