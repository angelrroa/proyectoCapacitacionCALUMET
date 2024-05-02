/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Logica;

import java.util.List;

/**
 *
 * @author aroadev
 */
public interface InterfaceUsuario {
    public Usuario getUsuario();
    public List<Usuario> listarUsuario();
    public boolean guardarUsuario();
    public boolean editarUsuario();
    public boolean eliminarUsuario();
}
