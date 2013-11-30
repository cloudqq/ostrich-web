# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
        options =
                column_names: ["SP编号","SP名称","付款周期","创建时间","操作"]
                url: "/sp_info/list_for_table.json"
                paging: true
        adv_options =
                aLengthMenu: [10,25,50]
        
        $("#xyz").easyTable options, adv_options
