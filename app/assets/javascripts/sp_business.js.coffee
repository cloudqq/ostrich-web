# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


@sp_business_search = ->
  params = []


  var_spname = $("#input_spname").val()
  var_spnumber = $("#input_spnumber").val()
  var_cmd = $("#input_cmd").val()

  if var_spname != undefined
    params.push({ name: "spname", value: var_spname})
  if var_spnumber != undefined
    params.push({ name: "spnumber", value: var_spnumber})
  if var_cmd != undefined
    params.push({ name: "cmd", value: var_cmd})

  load_business_list(params)




@load_business_list = (server_params) ->
  params =
    sNewLine: "<br>"
    sButtonText: "Copy to element"
    sDiv: ""
    fnClick: (nButton, oConfig) ->
      $(window).attr("location", "/sp_business/create")
                  
  TableTools.BUTTONS.create_new_sp_business_div = $.extend true, TableTools.buttonBase, params
          
  options =
    column_names: ["SP名称","业务名称","特服号码","指令","类型","单价","创建时间","操作"]
    url: "/sp_business/list_for_table.json"
    paging: true
    server_params: server_params
  adv_options =
    aLengthMenu: [10,25,50]
    bSort:false
    oTableTools:
      aButtons:[
        sExtends: "create_new_sp_business_div"
        sButtonText: "新建通道"
        sDiv: "copy"
      ]
    aoColumnDefs:[
      {
        sWidth: "20%"
        aTargets:[0]
      },
      {
        sWidth: "14%"
        aTargets:[1]
      },
      {
        sWidth: "16%"
        aTargets:[2]
      },
      {
        sWidth: "10%"
        aTargets:[3]
      },
      {
        sWidth: "6%"
        aTargets:[4]
        mRender: (data,type,row) ->
          switch data
            when 1 then "模糊"
            when 2 then "精确"
      },
      {
        sWidth: "10%"
        aTargets:[5]
      },
      {
        sWidth: "10%"
        aTargets:[6]
      },
      {
        sWidth: "14%"
        aTargets:[7],
        mRender: (data,type,row) ->
          """
            <a href=/sp_business/configure/#{data.business_uid}>配置</a> |
            <a href=/sp_business/policy/#{data.business_uid}>省份</a> |
            <a href=/sp_business/mt/#{data.business_uid}>MT</a>
          """
      },                                          
    ]
    aoColumns: [
      {
        aTargets:[0],
        mData: "spname"
      },
      {
        aTargets:[1],
        mData: "business_name"
      },
      {
        aTargets:[2],
        mData: "spnumber"
      },
      {
        aTargets:[3],
        mData: "cmd"
      },
      {
        aTargets:[4],
        mData: "cmdtype"
      },
      {
        aTargets:[5],
        mData: "price"
      },
      {
        aTargets:[6],
        mData: "createtime"
      },
      {
        aTargets:[7],
        mData: (source, type, val) ->
          {
            business_uid : source.id
          }
      }
    ]

  $("#business_table").easyTable options, adv_options

@load_business_mt = () ->
  options =
    column_names: ["MT内容","操作"]
    url: "/sp_business/mt_for_table.json"
    paging: true
    server_params: server_params
  adv_options =
    aLengthMenu: [10,25,50]
    bSort:false
    aoColumnDefs:[
      {
        sWidth: "80%"
        aTargets:[0]
      },
      {
        sWidth: "20%"
        aTargets:[1]
        mRender: (data,type,row) ->
          """
            <a href=# onclick='remove_mt(#{row.id});return false;'>删除</a>
          """
      }
    ]
    aoColumns: [
      {
        aTargets:[0],
        mData: "mt_content"        
      },
      {
        aTargets:[1],
        mData: "sp_business_id"
      }
    ]

  $("#mt_list_table").easyTable options, adv_options

@remove_mt = (id) ->
  $.ajax
    url: "/sp_business/remove_mt"
    type: "POST"
    dataType: "text"
    data:
      id: id
    success: ->
      load_business_mt()
    error: (xhr,error,thrown) ->
      alert('fail')  

@add_new_mt = (sp_business_id) ->
  mt = $("#input_mt").val()
  $.ajax
    url: "/sp_business/add_new_mt"
    type: "POST"
    dataType: "text"
    data:
      sp_business_id: sp_business_id
      mt_content: mt
    success: ->
      load_business_mt();
    error: (xhr,error,thrown) ->
      alert('fail')  