package com.golden.report.util;

import org.apache.poi.xwpf.usermodel.*;
import org.junit.Test;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by syq on 6/17/2018.
 */
public class WordUtilTest {
    @Test
    public void testChar() {
        String text = "|_| Self-owned   |_| Wholly Owned  |_| Shareholder/Partner|_| Kindred between Owners    |_| Cooperation Partner";
        System.out.println(text);
        String text2 = text.replaceAll("u007C_u007C", "√");
        System.out.println(">>"+text2);
        if(text.contains("|_|")) {
            String text3 = text.replaceAll("\\|_\\|", "√");
            System.out.println(">>>"+text3);
        }
    }

    @Test
    public void testWord() throws IOException {
        InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("TEST_gongmaoyiti.docx");
        XWPFDocument doc = new XWPFDocument(inputStream);
        /*for (XWPFParagraph p : doc.getParagraphs()) {
            List<XWPFRun> runs = p.getRuns();
            if (runs != null) {
                for (XWPFRun r : runs) {
                    String text = r.getText(0);
                    if (text != null && text.contains("lala")) {
                        text = text.replace("lala", "1111hahahah");
                        r.setText(text, 0);
                    }
                }
            }
        }*/
        /*for (XWPFParagraph p : doc.getParagraphs()) {
            System.out.println(p.getText());
        }*/
        /*for (XWPFTable tbl : doc.getTables()) {
            for (XWPFTableRow row : tbl.getRows()) {
                for (XWPFTableCell cell : row.getTableCells()) {
                    for (XWPFParagraph p : cell.getParagraphs()) {
                        for (XWPFRun r : p.getRuns()) {
                            String text = r.getText(0);
                            if (text != null && text.contains("$lala$")) {
                                text = text.replace("$lala$", "2222hahahah");
                                r.setText(text,0);
                            }
                        }
                    }
                }
            }
        }*/
        String checked = "√";
        String unchecked = "|_|";
        for (XWPFTable tbl : doc.getTables()) {
            for (XWPFTableRow row : tbl.getRows()) {
                for (XWPFTableCell cell : row.getTableCells()) {
                    for (XWPFParagraph p : cell.getParagraphs()) {
                        for (XWPFRun r : p.getRuns()) {
                            String text = r.getText(0);
                            System.out.println(text);
                            if (text != null && text.contains("|_|")) {
                                text = text.replaceAll("\\|_\\|", checked);
                                System.out.println(">>" + text);
                                r.setText(text,0);
                                System.out.println(">> >>" + r.getText(0));
                            }
                        }
                    }

                    /*System.out.println(cell.getText());
                    if (cell.getText() != null && cell.getText().contains("|_|")) {
                        String text = cell.getText().replaceAll("\\|_\\|", checked);
                        System.out.println(">>" + text);
                        cell.setText(text);
                        System.out.println(">> >>" + cell.getText());
                    }*/

                }
            }
        }
        doc.write(new FileOutputStream("output.docx"));
    }
}
