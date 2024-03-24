class MatrixCalculatorController < ApplicationController


	def index
	end
  

  def multiply
  	matrix1 = params[:matrix1]
    matrix2 = params[:matrix2]
      if matrix1.blank? || matrix2.blank?
        @error_message = "Please provide valid matrices."
      else
      begin
		    matrix1 = JSON.parse(matrix1)
	      matrix2 = JSON.parse(matrix2)
	      @result = matrix_multiply(matrix1, matrix2)
	    rescue JSON::ParserError => e
	    end
	      unless @result
	        @error_message = "Matrices cannot be multiplied."
	      end
	    end
			  respond_to do |format|
			    format.html
			  end
  end


  private 
    def matrix_multiply(a, b)
		  rows_a = a.length
		  cols_a = a[0].length
		  rows_b = b.length
		  cols_b = b[0].length
	  if cols_a != rows_b
	    puts "Matrices cannot be multiplied."
	    return
	  end
    result = Array.new(rows_a) { Array.new(cols_b, 0) }
     for i in 0...rows_a
	    for j in 0...cols_b
	      for k in 0...cols_a
	        result[i][j] += a[i][k] * b[k][j]
	      end
	    end
	  end
	  return result
  end

end

