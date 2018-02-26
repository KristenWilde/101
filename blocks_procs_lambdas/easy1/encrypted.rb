def decipher(string)
  string.chars.map {|chr| rotate13(chr) }.join
end

def rotate13(char)
  return char unless char.match(/[a-z, A-Z]/)
  key = if char.downcase == char then ("a".."z").to_a
        else ("A".."Z").to_a
        end
  key.rotate(key.index(char))[13]
end

names = %w( Nqn Ybirynpr
            Tenpr Ubccre
            Nqryr Tbyqfgvar
            Nyna Ghevat
            Puneyrf Onoontr
            Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
            Wbua Ngnanfbss
            Ybvf Unyog
            Pynhqr Funaaba
            Fgrir Wbof
            Ovyy Tngrf
            Gvz Orearef-Yrr
            Fgrir Jbmavnx
            Xbaenq Mhfr
            Wbua Ngnanfbss
            Fve Nagbal Ubner
            Zneiva Zvafxl
            Lhxvuveb Zngfhzbgb
            Unllvz Fybavzfxv
            Tregehqr Oynapu )

names.each {|name| puts decipher name }         
