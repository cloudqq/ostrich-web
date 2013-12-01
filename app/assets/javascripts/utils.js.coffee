$ = jQuery
$.fn.easyTable = (options,adv_options) ->
  table_id = "tbid_" + new Date().getTime() + + ""
  if options.table_id != undefined
    table_id = options.table_id
  else
    table_id = table_id

  if options.column_names != undefined
    table_def = '<table id="' + table_id + '" cellspacing="1" cellpadding="0" width="100%"><thead>'
    for name in options.column_names
        table_def += "<th>" + name + "</th>"
    table_def += "</thead><tbody></tbody></table>"

  this.html(table_def)

  dom_def = 'rt'
  if options.search
    dom_ref = '<"top">f>rt'

  if options.paging
    dom_ref += '<"bottom"ilp><"clear">'

  settings =
    fnServerData: (url,data,callback,oSettings) ->
      oSettings.jqXHR = $.ajax
        url: oSettings.sAjaxSource || options.url
        type: "GET"
        dataType: "json"
        data: data
        success: callback
        error: (xhr,error,thrown) ->
          alert('error')
    bPaginate: false
    sDom: 'T<"clear">lfrtip'
    sPaginationType: "bootstrap"
    bServerSide: true
    bProcessing: true
    aaSorting: []
    aoColumnDefs: [{ bSortable: false, aTargets: []}]
    sAjaxSource: options.url

  if options.sorting != undefined
    settings.aaSorting = options.sorting
  if options.server_side != undefined
    settings.bServerSide = options.server_side
  if options.paging != undefined
    settings.bPaginate = options.paging

  if adv_options != undefined
    settings = $.extend(settings, adv_options)
  oTable = this.children('table').dataTable(settings)
    
