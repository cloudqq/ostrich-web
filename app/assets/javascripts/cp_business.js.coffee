# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@cp_business_search = (offline) ->
  params = []

  var_spname = $("#input_spname").val()
  var_cpname = $("#input_cpname").val()
  var_spnumber = $("#input_spnumber").val()
  var_cmd = $("#input_cmd").val()

  if var_spname != undefined
    params.push({ name: "spname", value: var_spname})
  if var_cpname != undefined
    params.push({name: "cpname", value: var_cpname})
  if var_spnumber != undefined
    params.push({ name: "spnumber", value: var_spnumber})
  if var_cmd != undefined
    params.push({ name: "cmd", value: var_cmd})
  if (offline)
    params.push({name:"offline", value: true})
  list_cp_business_table(params)
  
@list_cp_business_table = (params) ->
  options =
    column_names: ["SP名称","CP名称","特服号码","指令","金额","结算","扣量","状态","创建时间","操作"]
    url: "/cp_business/list_for_table.json"
    paging: true
    server_params: params

  cb_row =  (nRow,aData,iDisplayIndex,iDisplayIndexFull) ->
    if aData.offline == 0
      create_buttons = "<a href=/cp_business/configure/#{aData.id}>配置</a> | <a href=/cp_policy/create/#{aData.id}>新建策略</a> | <a href='#' onclick='make_offline(#{aData.id}, #{iDisplayIndex}); return false;'>下线</a>"
      update_buttons = "<a href=/cp_business/configure/#{aData.id}>配置</a> | <a href=/cp_policy/configure/#{aData.policyid}>修改策略</a> | <a href='#' onclick='make_offline(#{aData.id}, #{iDisplayIndex}); return false;'>下线</a>"
      if aData.policyid == 0
        $("td:eq(9)",nRow).html(create_buttons)
      else
        $("td:eq(9)",nRow).html(update_buttons)
    else
      $("td:eq(9)",nRow).html("")
    return
  adv_options =
    aLengthMenu: [10,25,50]
    bSort: false
    fnRowCallback: cb_row
    aoColumns:[
      {
        aTargets:[0]
        mData: 'spname'
      },
      {
        aTargets:[1]
        mData: 'cpname'
      },
      {
        aTargets:[2]
        mData: 'spnumber'
      },
      {
        aTargets:[3]
        mData: 'cmd'
      },
      {
        aTargets:[4]
        mData: 'price'
      },
      {
        aTargets:[5]
        mData: 'pay_percent'
      },
      {
        aTargets:[6]
        mData: 'dis_percent'
      },
      {
        aTargets:[7]
        mData: 'status'
      },
      {
        aTargets:[8]
        mData: 'createtime'
      },
      {
        aTargets:[9]
        mData: (source, type, val) ->
          {
            cp_business_id: source.id
            policy_id: source.policyid
          }
      }                                                      
    ]
    aoColumnDefs:[
      {
        sWidth:"15%"
        aTargets:[0]
      },
      {
        sWidth:"10%"
        aTargets:[1]
      },
      {
        sWidth:"10%"
        aTargets:[2]
      },
      {
        sWidth:"10%"
        aTargets:[3]
      },
      {
        sWidth:"10%"
        aTargets:[4]
      },
      {
        sWidth:"6%"
        aTargets:[5]
      },
      {
        sWidth:"6%"
        aTargets:[6]
      },
      {
        sWidth:"6%"
        aTargets:[7]
        mRender: (data,type,row) ->
          switch data
            when 0 then "关闭"
            when 1 then "正常"
      },
      {
        sWidth:"10%"
        aTargets:[8]
      },
      {
        sWidth:"17%"
        aTargets:[9]
      }
    ]
        
  $("#cp_business_table").easyTable options, adv_options

@make_offline = (cp_business_id, row_idx) ->
  rowObj = $("#cp_business_table tr:eq(#{row_idx+1})")
  cpname = $("td:eq(1)", rowObj).text()
  spnumber = $("td:eq(2)", rowObj).text()
  cmd = $("td:eq(3)", rowObj).text()
  bootbox.confirm "是否确认下线 #{cpname}  #{spnumber} #{cmd} ?" , (result) ->
    if result
      $.ajax
        url: "/cp_business/make_offline"
        type: "POST"
        dataType: "text"
        data:
          id: "#{cp_business_id}"
        success: ->
          cp_business_search(false);
        error: (xhr,error,thrown) ->
          alert('fail')

