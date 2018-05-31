  private String getCellValue(Row row, int col) {
        Cell cell = row.getCell(col);
        if(cell == null) {
            return "";
        }

        String cellValue = "";
        DataFormatter formatter = new DataFormatter();
        switch(cell.getCellTypeEnum()) {
            case FORMULA:
                cell.setCellType(CellType.STRING);
                cellValue = formatter.formatCellValue(cell);
                break;
            case BLANK:
                break;
            default:
                cellValue = formatter.formatCellValue(cell);
        }

        return cellValue.trim();
    }

    private String getCellDateValue(Row row, int col) {
        Cell cell = row.getCell(col);
        DataFormatter formatter = new DataFormatter();
        if(cell == null || "".equalsIgnoreCase(formatter.formatCellValue(cell))) {
            return "";
        }

        SimpleDateFormat sdf = new SimpleDateFormat("M/d/yyyy");
        String cellValue = sdf.format(cell.getDateCellValue());

        return cellValue.trim();
    }
