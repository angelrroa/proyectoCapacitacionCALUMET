/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Logica;

import Persistencia.conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author aroadev
 */
public class Usuario implements InterfaceUsuario {

    private String identificacion;
    private String nombres;
    private String apellidos;
    private String telefono;
    private String direccion;
    private String tipo_id;

    public Usuario(String identificacion, String nombres, String apellidos, String telefono, String direccion, String tipo_id) {
        this.identificacion = identificacion;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.direccion = direccion;
        this.tipo_id = tipo_id;
    }

    public Usuario(String identificacion,String nombres, String apellidos, String telefono, String direccion) {
        this.identificacion = identificacion;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.direccion = direccion;

    }

    public Usuario() {
    }

    public Usuario(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTipo_id() {
        return tipo_id;
    }

    public void setTipo_id(String tipo_id) {
        this.tipo_id = tipo_id;
    }

    @Override
    public String toString() {
        return "\nUsuario \n" + "tipo de identificacion: " + tipo_id + "\nidentificación: " + identificacion + "\nnombres: " + nombres + "\napellidos: " + apellidos + "\ntelefono: " + telefono + "\ndireccion: " + direccion; // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    public boolean guardarUsuario() {
        boolean exito = false;
        conexion conexion = new conexion();
        String sql = "INSERT INTO usuarios (identificacion, nombres, apellidos, telefono, direccion, tipo_id) VALUES (?, ?, ?, ?, ?, ?)";

        if (conexion.setAutoCommitBD(false)) {
            try {
                PreparedStatement pstmt = conexion.getConnection().prepareStatement(sql);
                pstmt.setString(1, this.identificacion);
                pstmt.setString(2, this.nombres);
                pstmt.setString(3, this.apellidos);
                pstmt.setString(4, this.telefono);
                pstmt.setString(5, this.direccion);
                pstmt.setString(6, this.tipo_id);

                if (pstmt.executeUpdate() > 0) {
                    conexion.commitBD();
                    exito = true;
                } else {
                    conexion.rollbackBD();
                }
            } catch (SQLException ex) {
                System.out.println("Error al ejecutar la consulta SQL: " + ex.getMessage());
                conexion.rollbackBD();
            } finally {
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }

        return exito;
    }

    @Override
    public Usuario getUsuario() {
        String sql = "SELECT * FROM marca WHERE identificacion=" + this.identificacion + ";";
        conexion conexion = new conexion();

        try {
            ResultSet rs = conexion.consultarBD(sql);
            if (rs.next()) {
                this.tipo_id = rs.getString("tipo_id");
                this.identificacion = rs.getString("identificacion");
                this.nombres = rs.getString("nombres");
                this.apellidos = rs.getString("apellidos");
                this.telefono = rs.getString("telefono");
                this.direccion = rs.getString("direccion");
            }
        } catch (SQLException ex) {
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }

    @Override
    public List<Usuario> listarUsuario() {
        List<Usuario> listaUsuarios = new ArrayList<>();
        conexion conexion = new conexion();
        String sql = "SELECT * FROM usuarios;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            Usuario u;
            while (rs.next()) {
                u = new Usuario();
                u.setIdentificacion(rs.getString("identificacion"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidos(rs.getString("apellidos"));
                u.setTelefono(rs.getString("telefono"));
                u.setDireccion(rs.getString("direccion"));
                u.setTipo_id(rs.getString("tipo_id"));

                listaUsuarios.add(u);
            }
        } catch (SQLException ex) {
            System.out.println("Error al recuperar usuarios de la base de datos: " + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }

        // Debug: Imprimir la lista de usuarios recuperada
        System.out.println("Lista de usuarios recuperada:");
        for (Usuario usuario : listaUsuarios) {
            System.out.println(usuario);
        }

        return listaUsuarios;
    }

    @Override
    public boolean editarUsuario() {
        boolean exito = false;
        String sql = "UPDATE usuarios SET nombres='" + this.nombres + "',apellidos='" + this.apellidos
                + "',telefono='" + this.telefono + "',direccion='" + this.direccion 
                + "' WHERE identificacion='" + this.identificacion + "';";
        conexion conexion = new conexion();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                exito = true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }

    @Override
    public boolean eliminarUsuario() {
        boolean exito = false;
        String sql = "DELETE FROM usuarios WHERE identificacion = '" + this.identificacion + "';";
        conexion conexion = new conexion();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                exito = true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }
}
