node do
  {
    'sEcho' => @extra,
    'iTotalRecords' => @items.count,
    'iTotalDisplayRecords' => @items.count,
  }
end
node :aaData do
  @items.map do |u|
    attribute :spname => u.SPNAME,
              :businessid =>  u.BUSINESSID,
              :spnumber =>  u.SPNUMBER,
              :cmd =>  u.CMD,
              :business_name => u.BUSINESS_NAME,
              :price =>  u.PRICE,
              :businesstype =>  u.BUSINESSTYPE,
              :createtime =>  u.CREATETIME.strftime("%Y-%m-%d"),
              :options =>  "",
              :spid =>  u.SPID,
              :cmdtype =>  u.CMDTYPE,
              :id =>  u.ID,
              :isassign =>  u.ISASSIGN,
              :arealist =>  u.AREALIST
  end
end

