# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
#
@sp_info_search = ->
  params = []
  var_spname = $("#input_spname").val()

  if var_spname != undefined
    params.push( { name: "spname", value: var_spname })


  list_sp_info_table(params)

@list_sp_info_table = (params) ->
        options =
                column_names: ["编号","名称","业务类型","接口类型","付款周期","创建时间","状态","操作"]
                url: "/sp_info/list_for_table.json"
                paging: true
                dom:'<"clear">tlpi'
                server_params: params
        adv_options =
                aLengthMenu: [10,25,50]
                bSort: false
                aoColumnDefs:[
                  {
                    sWidth: "6%",
                    aTargets: [0]
                  },
                  {
                    sWidth: "20%",
                    aTargets: [1]
                  },
                  {
                    sWidth: "10%",
                    aTargets:[3],
                    mRender: (data,type,row) ->
                     if data == 0 then "MO/MR" else "组合"                                            
                  },
                  {
                    sWidth: "10%",
                    aTargets: [2],
                    mRender: (data, type, row) ->
                      if data == 0
                        "短信"
                      else
                        "IVR"                    
                  },
                  {
                    sWidth: "10%",
                    aTargets: [4],
                    mRender: (data,type,row) ->
                      type = switch data.payperiodtype
                               when 1 then "天"
                               when 2 then "周"
                               when 3 then "月"
                              
                      "#{data.payperiod} #{type}"
                  },
                  {
                    sWidth: "10%",
                    aTargets: [5]
                  },
                  {
                    sWidth: "%6",
                    aTargets: [6],
                    mRender: (data,type,row) ->
                      if data == 0
                        "关闭"
                      else
                        "正常"
                  },
                  {
                    aTargets:[7]
                    sWidth: "28%"
                    mRender: (data, type, row) ->
                      """
                      <a href=/sp_info/configure/#{data}>配置</a> |
                      <a href=/sp_business/list/#{data}>通道</a> |
                      <a href=/sp_business/create?spid=#{data}>新建通道</a>
                      """
                  }                        
                ]
                aoColumns:[
                  {
                    aTargets:[0],
                    mData: "spid"
                  },
                  {
                    aTargets:[1],
                    mData: "spname"
                  },
                  {
                    aTargets:[2],
                    mData: "catagory"
                  },
                  {
                    aTargets:[3],
                    mData: "accepttype"
                  },                  
                  {
                    aTargets:[4],
                    mData: (source, type, val) ->
                      {
                        payperiod: source.payperiod
                        payperiodtype: source.payperiodtype
                      }
                  },
                  {
                    aTargets:[5],
                    mData: "createtime"
                  },
                  {
                    aTargets:[6],
                    mData: "status"
                  },
                  {
                    aTargets:[7],
                    mData: (source, type, val) ->
                      source.spid
                  }
                ]

        $("#sp_info_table").easyTable options, adv_options

# 配置界面                

$ ->
        $("#btn_spinfo_create_and_configure").click (event) ->
                $("#sp_info_create_form").attr("action","/sp_info/submit_create_and_configure_spinfo")
                $("#sp_info_create_form").submit()

$ ->
        $("#btn_spinfo_create").click (event) ->
                $("#sp_info_create_form").attr("action","/sp_info/submit_create_spinfo")
                $("#sp_info_create_form").submit()

