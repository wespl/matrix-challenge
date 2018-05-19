class Matrix
  def initialize(arr)
    @data = arr
  end

  def dim
    rows = @data.length
    cols = @data[0].length
    {rows: rows, cols: cols}
  end

  def cols
    dim[:cols]
  end

  def rows
    dim[:rows]
  end

  def [](i,j)
    @data[i-1][j-1]
  end

  def []=(i,j,v)
    @data[i-1][j-1] = v
  end

  def self.zero(n)
    Matrix.new(Array.new(n) {Array.new(n) {0}})
  end

  def self.id(n)
    d = Matrix.new(Array.new(n) {Array.new(n) {0}})
    (1..n).each do |x|
      d[x,x] = 1
    end
    d
  end

  def row(i)
    @data[i-1]
  end

  def col(j)
    @data.map do |r|
      r[j-1]
    end
  end

  def minor(i,j)
    want_rows = (1..rows).select{|x| x != i}.map{|x| row(x)}
    min = want_rows.map do |row|
      row.select.with_index do |v,col|
        col != j - 1
      end
    end
    Matrix.new(min)
  end

  def det
    if rows != cols
      nil
    elsif rows == 1
      self[1,1]
    else
      i = 1 #always expand along row 1
      terms = (1..cols).map do |j|
        self[i,j] * ((-1) ** (i + j)) * minor(i,j).det
      end
      terms.reduce(:+)
    end
  end

end
