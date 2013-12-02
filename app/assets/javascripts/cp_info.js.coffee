# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
params =
        sNewLine: "<br>"
        sButtonText: "Copy to element"
        sDiv: ""
        fnClick: (nButton, oConfig) ->
                $(window).attr("location", "/cp_info/create")
                
TableTools.BUTTONS.create_new_cp_info_div = $.extend true, TableTools.buttonBase, params

tool_option = aButtons: [ sExtends: "create_new_cp_info_div", sButtonText: "创建CP", sDiv: "copy"]

jQuery ->
        options =
                column_names: ["CP编号","登录账号","真实名称","状态","接入时间","操作"]
                url: "/cp_info/list_for_table.json"
                paging: true
        adv_options =
                aLengthMenu: [10,25,50]
                oTableTools: tool_option

        
        $("#cp_info_table").easyTable options, adv_options

@list_cmd_assignment_table = (server_params) ->
        column_defs = [
                mRender: (data,type,row) ->
                        data + "xyz"
                aTargets: [0],
                fnCreatedCell: (nTd,sData,oData,iRow,iCol) ->
                        $(nTd).prepend($("<b>OK</b>"))
                sTitle: "Holy shit",
                mRender: (data,type,row) ->
                        "OOO"
                aTargets: [6]
        ]
                
        options =
                column_names:["SP名称","特服号","指令","结算比例","扣量比例","通道概要","操作"]
                url: "/cp_info/list_for_assignment_table.json"
                paging: true
        adv_options =
                aLengthMenu: [10,25,50]
                oTableTools: tool_option
                aoColumnDefs: column_defs
                aoColumns:[
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        mData:null
                ]
        $("#cmd_assignment_table").easyTable options, adv_options
                

