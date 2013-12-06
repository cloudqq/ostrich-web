# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@cp_business_search = ->
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

  list_cp_business_table(params)
    
  
@list_cp_business_table = (params) ->
  options =
    column_names: ["SP名称","CP名称","特服号码","指令","金额","结算比例%","扣量比例%","状态","创建时间","操作"]
    url: "/cp_business/list_for_table.json"
    paging: true
    server_params: params

  adv_options =
    aLengthMenu: [10,25,50]
    bSort: false
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
          }
      }                                                      
    ]
    aoColumnDefs:[
      {
        swidth:"15%"
        aTargets:[0]
      },
      {
        swidth:"20%"
        aTargets:[1]
      },
      {
        swidth:"10%"
        aTargets:[2]
      },
      {
        swidth:"10%"
        aTargets:[3]
      },
      {
        swidth:"10%"
        aTargets:[4]
      },
      {
        swidth:"6%"
        aTargets:[5]
      },
      {
        swidth:"6%"
        aTargets:[6]
      },
      {
        swidth:"%%"
        aTargets:[7]
        mRender: (data,type,row) ->
          switch data
            when 0 then "关闭"
            when 1 then "正常"
      },
      {
        swidth:"10%"
        aTargets:[8]
      },
      {
        swidth:"10%"
        aTargets:[9]
        mRender: (data,type,row) ->
          """
            <a href=/cp_business/configure/#{data.cp_business_id}>配置</a>
          """
      }

    ]
        
  $("#cp_business_table").easyTable options, adv_options

