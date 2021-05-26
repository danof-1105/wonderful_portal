class AncestryValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # HACK: /で判断させるのは直感的ではないため別の方法も検討する
    if value.count("/") > 3
      record.errors.add(attribute, "ディレクトリは6つ以上作成できません！")
    end
  end
end
