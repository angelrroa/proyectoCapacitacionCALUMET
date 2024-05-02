<%-- 
    Document   : peticionesUsuarios
    Created on : 22/04/2024, 9:38:59 a. m.
    Author     : aroadev
--%>


<%@page import="Logica.Usuario"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.Gson"%> <%--Libreria para convertir objetos java a formato JSON--%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%
    String respuesta = "{";

    List<String> tareas = Arrays.asList(new String[]{
        "guardarUsuario",
        "listar",
        "eliminar",
        "actualizar"
    });
    String proceso = "" + request.getParameter("proceso");
    //String proceso = "listar";
    System.out.println("Proceso recibido: " + proceso);
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("guardarUsuario")) {
            String tipo_id = request.getParameter("tipo_id");
            String id_usuario = request.getParameter("id_usuario");
            String nombres = request.getParameter("nombre");
            String apellidos = request.getParameter("apellido");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            Usuario r = new Usuario(id_usuario, nombres, apellidos, telefono, direccion, tipo_id);

            if (r.guardarUsuario()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("listar")) {
            try {
                List<Usuario> lista = new Usuario().listarUsuario();
                respuesta += "\"" + proceso + "\": true,\"Usuarios\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Usuarios\":[]";
                Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("eliminar")) {
            String id_usuario = request.getParameter("id_usuario");
            Usuario r = new Usuario(id_usuario);
      
            if (r.eliminarUsuario()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        }else if (proceso.equals("actualizar")) {
            String id_usuario = request.getParameter("id_usuario");
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String telefono= request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
         
            Usuario r = new Usuario(id_usuario, nombres, apellidos,telefono,direccion);

            if (r.editarUsuario()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else {
            respuesta += "\"ok\": false,";
            respuesta += "\"error\": \"INVALID\",";
            respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                    + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
        }
    }

    respuesta += "}";
    response.setContentType("application/json;charset=UTF-8");
    out.print(respuesta);
%>