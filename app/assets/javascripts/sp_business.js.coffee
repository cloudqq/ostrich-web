# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@load_business_list = (server_params) ->
  params =
    sNewLine: "<br>"
    sButtonText: "Copy to element"
    sDiv: ""
    fnClick: (nButton, oConfig) ->
      $(window).attr("location", "/sp_business/create")
                  
  TableTools.BUTTONS.create_new_sp_business_div = $.extend true, TableTools.buttonBase, params
          
  options =
    column_names: ["通道ID","SPID","特服号码","指令","创建时间","操作"]
    url: "/sp_business/list_for_table.json"
    paging: true
    server_params: server_params
  adv_options =
    aLengthMenu: [10,25,50]
    oTableTools:
      aButtons:[
        sExtends: "create_new_sp_business_div"
        sButtonText: "新建通道"
        sDiv: "copy"
      ]

  $("#business_table").easyTable options, adv_options

