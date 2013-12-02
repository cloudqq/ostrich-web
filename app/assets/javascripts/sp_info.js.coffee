# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
#
params =
        sNewLine: "<br>"
        sButtonText: "Copy to element"
        sDiv: ""
        fnClick: (nButton, oConfig) ->
                $(window).attr("location", "/sp_info/create")
col_defs = [
        {
        sWidth: "10%",
        aTargets: [0]
        }
        ,
        {
        sWidth: "50%",
        aTargets: [1]
        },
        {
        sWidth: "10%",
        aTargets: [2]
        },
        {
        sWidth: "20%",
        aTargets: [3]
        },
        {
        sWidth: "10%",
        aTargets: [0]
        }                        
]            

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
                aoColumnDefs: col_defs

        $("#xyz").easyTable options, adv_options

$ ->
        $("#btn_spinfo_create_and_configure").click (event) ->
                $("#sp_info_create_form").attr("action","/sp_info/submit_create_and_configure_spinfo")
                $("#sp_info_create_form").submit()

$ ->
        $("#btn_spinfo_create").click (event) ->
                $("#sp_info_create_form").attr("action","/sp_info/submit_create_spinfo")
                $("#sp_info_create_form").submit()

