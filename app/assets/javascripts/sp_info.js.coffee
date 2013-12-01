# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
params =
        sNewLine: "<br>"
        sButtonText: "Copy to element"
        sDiv: ""
        fnClick: (nButton, oConfig) ->
                $(window).attr("location", "/sp_info/create")

TableTools.BUTTONS.create_new_sp_div = $.extend true, TableTools.buttonBase, params

tool_option = aButtons: [ sExtends: "create_new_sp_div", sButtonText: "新建SP", sDiv: "copy"]

jQuery ->
        options =
                column_names: ["SP编号","SP名称","付款周期","创建时间","操作"]
                url: "/sp_info/list_for_table.json"
                paging: true
                dom:"<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
        adv_options =
                aLengthMenu: [10,25,50]
                oTableTools: tool_option

        $("#xyz").easyTable options, adv_options
