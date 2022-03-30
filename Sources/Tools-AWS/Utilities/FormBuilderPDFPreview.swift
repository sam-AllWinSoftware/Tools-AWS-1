import UIKit
import TPPDF

final class FormBuilderPDFPreview {
    
    // MARK: Private properties
    private var document: PDFDocument!
    private var generator: PDFGeneratorProtocol!
    
    // MARK: Public methods
    public func withFormat(_ format: PDFPageFormat) -> Self {
        document = PDFDocument(format: format)
        return self
    }
    
    public func withPages(_ pages: [Page]) -> Self {
        pages.forEach { page in
            drawRows(page.fieldRows)
        }
        document.pagination = addNumberOfPages()
        return self
    }

    public func withHeader(_ formName: String) -> Self {
        document.add(.headerLeft, textObject: PDFSimpleText(text: formName))
        let line = PDFLineStyle(type: .full, color: ThemeFactory.color(.sunBlue)!, width: 0.5)
        document.addLineSeparator(style: line)
        document.add(space: 10)
        return self
    }
    
    public func build() -> PDFGeneratorProtocol {
        generator = PDFGenerator(document: document)
        return generator
    }
    
    // MARK: Private methods
    private func addNumberOfPages() -> PDFPagination {
        PDFPagination(container: .footerRight,
                      style: PDFPaginationStyle.customClosure { (page, total) in
                        "\(page) / \(total)"
                      },
                      textAttributes: [
                        .font: Font.boldSystemFont(ofSize: 9.0)
                        //.foregroundColor: ThemeFactory.sun
                      ])
    }
    
    private func drawRows(_ fieldRows: [FieldRow]) {
        fieldRows.forEach { fieldRow in
            switch fieldRow.field {
            case .rating:
                drawRating(fieldRow)
            default:
                drawText(fieldRow)
            }
        }
    }
    
    private func drawText(_ fieldRow: FieldRow) {
        
        let text = "Empty"
        let table = PDFTable(rows: 1, columns: 1)
        table.content = [[text]]
        table.widths = [1.0]
        table.padding = 10.0
        table.margin = 10.0
        var styleColum = PDFTableCellStyle()
        let lineStyle = PDFLineStyle(type: .full, color: .darkGray, width: 0.5, radius: 2)
        styleColum.borders = PDFTableCellBorders(left: lineStyle, top: lineStyle, right: lineStyle, bottom: lineStyle)
        styleColum.font = Font.systemFont(ofSize: 10)
        styleColum.colors = (fill: .white, text: .black)
        table.columns.allColumnsStyle = [styleColum]
        table.rows.allRowsAlignment = [.left]
        
        let title = NSMutableAttributedString(string: "Text", attributes: [
            .font: Font.systemFont(ofSize: 7.0),
            .backgroundColor: UIColor.white
        ])
        
        document.add(space: 10)
        document.add(.contentLeft, attributedText: title)
        document.add(table: table)
        document.add(space: 10)
    }
    
    // TODO: Add logic for filled start
    private func drawRating(_ fieldRow: FieldRow) {
        let table = PDFTable(rows: 1, columns: 5)
        let imageRatingFill = UIImage(named: "RatingFill")
        let imageStroke = UIImage(named: "RatingStroke")
        
        table.content = [
            [imageRatingFill, imageRatingFill, imageStroke, imageStroke, imageStroke]
        ]
        
        table.widths = [
            0.1, 0.1, 0.1, 0.1, 0.1
        ]
        var styleColum = PDFTableCellStyle()
        styleColum.colors = (fill: .white, text: .white)
        table.columns.allColumnsStyle = [styleColum]
        table.padding = 5.0
        table.margin = 10.0
        table.rows.allRowsAlignment = [.center]
        
        let title = NSMutableAttributedString(string: "Rating", attributes: [
            .font: Font.systemFont(ofSize: 7.0),
            .backgroundColor: UIColor.white
        ])
        
        document.add(space: 10)
        document.add(.contentLeft, attributedText: title)
        document.add(table: table)
        document.add(space: 10)
    }
}
