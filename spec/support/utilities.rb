include ApplicationHelper

def long(attr)
  case attr
  when :name then return "a"*51
  when :email then return "a"*23 + '@' + "a"*22 + '.asdf'
  end
  false
end