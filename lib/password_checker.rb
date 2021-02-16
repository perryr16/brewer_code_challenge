require 'pry'
class PasswordChecker

  def initialize(pw_hash)
    @pw_hash = pw_hash
  end

  def count_valid 
    pw_hash = JSON.parse(@pw_hash)
    count = 0
    check_passwords(pw_hash, count)
  end

  def check_passwords(pw_hash, count)
    pw_hash.each do |k,v|
      reqs = format_reqs(k)
      if reqs[:letter]
        true_condition = v.count(reqs[:letter]) >= reqs[:min] && v.count(reqs[:letter]) <= reqs[:max] 
        true_condition && count += 1
      end
    end
    count
  end

  def format_reqs(key)
    pw_reqs = key.split('-')
    pw_reqs[1] = pw_reqs[1].split(' ')
    pw_reqs = pw_reqs.flatten 
    min = pw_reqs[0].to_i
    max = pw_reqs[1].to_i
    letter = pw_reqs[2]
    {min: min, max: max, letter: letter}
  end

end
