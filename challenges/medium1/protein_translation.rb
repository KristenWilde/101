class InvalidCodonError < StandardError
end

class Translation
  KEY = { "Methionine" => ["AUG"],
             "Phenylalanine" => ['UUU', 'UUC'],
             "Leucine" => ['UUA', 'UUG'],
             "Serine" => ['UCU', 'UCC', 'UCA', 'UCG'],
             "Tyrosine" => ['UAU', 'UAC'],
             'Cysteine' => ['UGU', 'UGC'],
             'Tryptophan' => ['UGG'],
             'STOP' => ['UAA', 'UAG', 'UGA'] }
  
  def self.of_codon(codon)
    raise InvalidCodonError unless self.valid?(codon)
    result = nil
    KEY.each do |amino_acid, codons|
      result = amino_acid if codons.include?(codon)
    end  
    result
  end
  
  def self.of_rna(strand)
    protein = []
    strand.scan(/.../).each do |codon| 
      amino_acid = self.of_codon(codon) 
      if amino_acid == 'STOP' then break
      else protein << amino_acid
      end
    end
    protein
  end
  
  def self.valid?(codon)
    KEY.values.flatten.include?(codon)
  end
  
end

# p Translation.of_rna('AUGUUUUGG')