<%@page import= "org.zendesk.client.v2.Zendesk" %>
<%@page import= "org.zendesk.client.v2.model.CustomFieldValue" %>
<%@page import= "org.zendesk.client.v2.model.Ticket" %>
<%@page import= "java.util.*" %>
<%@page import= "org.apache.log4j.Logger" %>    
    <%
       final Logger logger = Logger.getLogger("zendeskapp");
       if (request.getParameter("id") == null) {
       logger.info("No id recieved!");
        out.println("No id recieved!");
       }
       else {
       logger.info("Id is recieved!" + request.getParameter("id")); 
        out.println("id " + request.getParameter("id")+"!");
        System.out.println("id " + request.getParameter("id"));
        String id1 = request.getParameter("id");
        Zendesk zd= new Zendesk.Builder("https://abcx.zendesk.com")
        .setUsername("hmistry16@gmail.com")
        .setPassword("9819938161").build();
       logger.info("Connection with zendesk established");
        Long id2 = Long.parseLong(id1);
        Ticket ticket = zd.getTicket(id2);
       logger.info("Ticket obtained by using the recieved id");
        List<CustomFieldValue> custpmFields = ticket.getCustomFields();
        String timeTrackingAppValue = "0";
        CustomFieldValue cfv1 = null;
        for (CustomFieldValue custFieVal : custpmFields)
            {
                if (custFieVal.getId() == 80067427l)
                {
                    timeTrackingAppValue = custFieVal.getValue();
                    logger.info("Time value retrieved for time tracking app:" + timeTrackingAppValue);
                }
                if (custFieVal.getId() == 80128147l)
                {
                    cfv1 = custFieVal;
                }
            }
            cfv1.setValue(timeTrackingAppValue);
            logger.info("Time value appended in the custom field:'Time required to solve the ticket' " + cfv1.getValue());
            zd.updateTicket(ticket);
            logger.info("Ticket updated!");    
            System.out.println(cfv1.getId() + " " + cfv1.getValue());
            zd.close();    
    }
    %> 