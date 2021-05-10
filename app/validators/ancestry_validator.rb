class AncestryValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.count("/") > 3
      record.errors.add("ディレクトリは6つ以上作成できません！")
    end
  end
end
