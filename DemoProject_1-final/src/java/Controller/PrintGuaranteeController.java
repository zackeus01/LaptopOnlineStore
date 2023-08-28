/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.text.Normalizer;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.pdfbox.exceptions.COSVisitorException;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.edit.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

/**
 *
 * @author win
 */
@WebServlet(name = "PrintGuaranteeController", urlPatterns = {"/printGuarantee"})
public class PrintGuaranteeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PrintGuaranteeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PrintGuaranteeController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String seri = request.getParameter("seri");
        String name = request.getParameter("name");
        String fullname = Normalizer.normalize(name, Normalizer.Form.NFD)
                .replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String describe = request.getParameter("describe");
        String datebuy = request.getParameter("buy");
        LocalDate currentDate = LocalDate.now();
        Date ReceivedDate = Date.valueOf(currentDate);
        String warrantyperiod = request.getParameter("period");
        String expense = request.getParameter("expense");
        try ( PDDocument document = new PDDocument()) {
            // Create a blank page and add it to the document
            PDPage page = new PDPage();
            document.addPage(page);
            response.setContentType("application/pdf;charset=UTF-8");
//            PDType0Font font = PDType0Font.load(document, new File("fonts/Courier.ttf"));
            try ( // Create a new content stream for adding content to the PDF
                     PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                //            PDType0Font font = PDType0Font.load(document, new File("fonts/Courier.ttf"));
                PDFont font = PDType1Font.HELVETICA_BOLD;
                // Set the font and position for the content                
                contentStream.beginText();
                contentStream.setFont(font, 12);
                contentStream.moveTextPositionByAmount(100, 700);
                contentStream.drawString("Information Guarantee");
                // Print the form data in the PDF
                // ...

                int lineSpacing = 20; // Adjust the line spacing as needed
                int currentPositionY = 700; // Adjust the starting position as needed

                contentStream.drawString("Serial Number: " + seri);
                currentPositionY -= lineSpacing;

                contentStream.beginText();
                contentStream.setFont(font, 12);
                contentStream.moveTextPositionByAmount(100, currentPositionY);
                contentStream.drawString("Information Guarantee");
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Serial Number: " + seri);
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Full Name: " + fullname);
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Email: " + email);
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Phone Number: " + phone);
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Address: " + address);
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Date Buy: " + datebuy);
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Warranty Period: " + warrantyperiod);
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Describe: " + describe);
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Received Date: " + ReceivedDate);
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Delivery Date: 7 day after received date");
                currentPositionY -= lineSpacing;

                contentStream.moveTextPositionByAmount(0, -20);
                contentStream.drawString("Expense: " + expense + " VND");
                currentPositionY -= lineSpacing;
                contentStream.endText();
                contentStream.endText();
            }
            response.setContentType("application/pdf");
            String fileName = "guarantee_invoice_" + fullname + ".pdf";
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            document.save(response.getOutputStream());
            document.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (COSVisitorException ex) {
            Logger.getLogger(PrintGuaranteeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String seri = request.getParameter("seri");
        String name = request.getParameter("name");
        String fullname = Normalizer.normalize(name, Normalizer.Form.NFD)
                .replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String describe = request.getParameter("describe");
        String datebuy = request.getParameter("buy");
        LocalDate currentDate = LocalDate.now();
        Date ReceivedDate = Date.valueOf(currentDate);
        String warrantyperiod = request.getParameter("period");
        String expense = request.getParameter("expense");
        response.setContentType("application/pdf");
        String fileName = "guarantee_invoice_" + fullname + ".pdf";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        try ( PDDocument document = new PDDocument()) {
            // Create a blank page and add it to the document
            PDPage page = new PDPage();
            document.addPage(page);
//            PDType0Font font = PDType0Font.load(document, new File("fonts/Courier.ttf"));
            try ( // Create a new content stream for adding content to the PDF
                     PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                //            PDType0Font font = PDType0Font.load(document, new File("fonts/Courier.ttf"));
                PDFont font = PDType1Font.TIMES_ROMAN;
                // Set the font and position for the content                
                contentStream.beginText();
                contentStream.setFont(font, 18);
                contentStream.moveTextPositionByAmount(100, 700);
                int lineSpacing = 20;
                contentStream.drawString("Information Guarantee");
                 contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("----------------------------------------------------------------" );
                // Print the form data in the PDF
                // ...                                              
                contentStream.setFont(font, 12);
                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Serial Number: " + seri);

                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Full Name: " + fullname);

                contentStream.moveTextPositionByAmount(0, -lineSpacing);;
                contentStream.drawString("Email: " + email);

                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Phone Number: " + phone);

                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Address: " + address);

                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Date Buy: " + datebuy);

                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Warranty Period: " + warrantyperiod);

                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Describe: " + describe);

                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Received Date: " + ReceivedDate);

                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Delivery Date: 7 day after received date");

                contentStream.moveTextPositionByAmount(0, -lineSpacing);
                contentStream.drawString("Expense: " + expense + " VND");

                contentStream.endText();
            }
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            document.save(response.getOutputStream());
            document.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (COSVisitorException ex) {
            Logger.getLogger(PrintGuaranteeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
