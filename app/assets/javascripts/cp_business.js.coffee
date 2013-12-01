# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
params =
        sNewLine: "<br>"
        sButtonText: "Copy to element"
        sDiv: ""
        fnClick: (nButton, oConfig) ->
                $(window).attr("location", "/cp_business/create")
                
TableTools.BUTTONS.create_new_cp_business_div = $.extend true, TableTools.buttonBase, params

tool_option = aButtons: [ sExtends: "create_new_cp_business_div", sButtonText: "新建", sDiv: "copy"]

jQuery ->
        options =
                column_names: ["CP名称","指令","特服号码","金额","结算比例","扣量比例","操作"]
                url: "/cp_business/list_for_table.json"
                paging: true
        adv_options =
                aLengthMenu: [10,25,50]
                oTableTools: tool_option
        
        $("#cp_business_table").easyTable options, adv_options

