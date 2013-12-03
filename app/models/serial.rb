class Serial < ActiveRecord::Base
  attr_accessible :CODE, :MAXNO, :LENGTH

  def self.new_serial (code)
    t = find_by_CODE code
    if t.nil?
      "ERROR"
    else
      targetno = t.MAXNO += 1
      t.save!
      t.CODE + targetno.to_s.rjust(t.LENGTH,"0")
    end
  end
end
