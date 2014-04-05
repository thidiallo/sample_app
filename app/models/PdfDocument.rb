class PdfDocument < Prawn::Document
  def to_pdf
    text "Article ", :size => 30, :style => :bold
    move_down(30)
    text "aguibou"
    move_down(10)

    render
  end
end
