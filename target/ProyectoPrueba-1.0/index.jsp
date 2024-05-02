<%-- 
    Document   : index
    Created on : 22/04/2024, 9:21:12 a. m.
    Author     : aroadev
--%>
<%@page import="Logica.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crud Básico</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    </head>
    <body ng-app="demoU1" ng-controller="u1Controller as u1">
        <div class="container mt-5" >
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <label ng-model="u1.titulo">Crear Usuario</label>
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="form-group">
                                    <label for="tipoIdentificacion">Tipo de Identificación</label>
                                    <select class="form-control" id="tipoIdentificacion" ng-model="u1.tipo_id" ng-disabled="u1.edicion" required>
                                        <option value="TI">Tarjeta de identidad</option>
                                        <option value="CC">Cedula de Ciudadania</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="numeroIdentificacion" >Número de Identificación</label>
                                    <input type="text" class="form-control" id="numeroIdentificacion" ng-model="u1.id_usuario" ng-disabled="u1.edicion" required>
                                </div>
                                <div class="form-group">
                                    <label for="nombres">Nombres</label>
                                    <input type="text" class="form-control" id="nombres" ng-model="u1.nombres">
                                </div>
                                <div class="form-group">
                                    <label for="apellidos">Apellidos</label>
                                    <input type="text" class="form-control" id="apellidos" ng-model="u1.apellidos">
                                </div>
                                <div class="form-group">
                                    <label for="telefono">Teléfono</label>
                                    <input type="tel" class="form-control" id="telefono" ng-model="u1.telefono">
                                </div>
                                <div class="form-group">
                                    <label for="direccion">Dirección</label>
                                    <input type="text" class="form-control" id="direccion" ng-model="u1.direccion">
                                </div>
                                <button type="submit" class="btn btn-primary"  ng-click="u1.validar()" ng-hide="u1.botonGuardar">Guardar</button>
                                <button type="submit" class="btn btn-outline-warning" ng-click="u1.actualizar()" ng-hide="u1.botonEditar">Actualizar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!--            <div class="col-3"><button type="button" class="btn btn-outline-primary" ng-click="u1.listarUsuarios()">Consultar</button></div>-->
        </div>
        <div class="container">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th scope="col">ID TIPO</th>
                        <th scope="col"># ID</th>
                        <th scope="col">NOMBRES</th>
                        <th scope="col">APELLIDOS</th>
                        <th scope="col">TELEFONO</th>
                        <th scope="col">DIRECCIÓN</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat=" u in u1.Usuarios">
                        <td>{{u.tipo_id}}</td>
                        <td>{{u.identificacion}}</td>
                        <td>{{u.nombres}}</td>
                        <td>{{u.apellidos}}</td>
                        <td>{{u.telefono}}</td>
                        <td>{{u.direccion}}</td>
                        <td><button class="btn btn-danger btn-sm" ng-click="u1.eliminar(u)">Eliminar</button></td>
                        <td><button class="btn btn-outline-warning" ng-click="u1.llenarDatosEdicion(u)">Editar</button></td>
                    </tr>

                </tbody>
            </table>
        </div>
        <script>
                    var app = angular.module('demoU1', []);
                    app.controller('u1Controller', ['$http', controladorU1]);
                    function controladorU1($http) {
                        var u1 = this;
                        u1.Usuarios = [];
                        u1.edicion = false;
                        u1.botoEditar=true;
                        u1.botonGuardar = false;

                        guardar = function () {
                            var parametros = {
                                proceso: 'guardarUsuario',
                                tipo_id: u1.tipo_id,
                                id_usuario: u1.id_usuario,
                                nombre: u1.nombres,
                                apellido: u1.apellidos,
                                telefono: u1.telefono,
                                direccion: u1.direccion
                            };
                            $http({
                                method: 'POST',
                                url: 'peticionesUsuarios.jsp',
                                params: parametros
                            }).then(function (res) {
                                if (res.data.ok === true) {
                                    if (res.data.guardarUsuario === true) {
                                        alert('Guardó Correctamente');
                                        window.location.reload();
                                    } else {
                                        alert('No Guardó');
                                    }
                                } else {
                                    alert(res.data.errorMsg);
                                }
                            });
                        };
                        u1.listarUsuarios = function () {
                            var parametros = {
                                proceso: 'listar'
                            };
                            $http({
                                method: 'POST',
                                url: 'peticionesUsuarios.jsp',
                                params: parametros
                            }).then(function (res) {
                                console.log(res.data);
                                u1.Usuarios = res.data.Usuarios;
                            }).catch(function (error) {
                                console.error('Error en la solicitud HTTP:', error);
                            });
                        };
                        u1.listarUsuarios();

                        u1.eliminar = function (u) {
                            var parametros = {
                                proceso: 'eliminar',
                                id_usuario: u.identificacion

                            };
                            $http({
                                method: 'POST',
                                url: 'peticionesUsuarios.jsp',
                                params: parametros
                            }).then(function (res) {
                                if (res.data.ok === true) {
                                    if (res.data.eliminar === true) {
                                        alert('Usuario eliminado');
                                        window.location.reload();
                                    } else {
                                        alert('No se eliminó');
                                    }

                                } else {
                                    alert(res.data.errorMsg);
                                }
                            });
                        };
                        u1.llenarDatosEdicion = function (u) {

                            u1.tipo_id = u.tipo_id;
                            u1.id_usuario = u.identificacion;
                            u1.nombres = u.nombres;
                            u1.apellidos = u.apellidos;
                            u1.telefono = u.telefono;
                            u1.direccion = u.direccion;
                            u1.edicion = true;
                            u1.botoEditar = false;
                            u1.botonGuardar = true;
                        };


                        u1.actualizar = function () {

                            var parametros = {
                                proceso: 'actualizar',
                                id_usuario: u1.id_usuario,
                                nombres: u1.nombres,
                                apellidos: u1.apellidos,
                                telefono: u1.telefono,
                                direccion: u1.direccion

                            };
                            $http({
                                method: 'POST',
                                url: 'peticionesUsuarios.jsp',
                                params: parametros
                            }).then(function (res) {
                                if (res.data.ok === true) {
                                    if (res.data.actualizar === true) {
                                        alert('Usuarios actualizado');
                                    } else {
                                        alert('No se actualizó');
                                    }

                                } else {
                                    alert(res.data.errorMsg);
                                }
                            });
                        };

                        u1.validar = function () {

                            if (u1.tipo_id === undefined || u1.id_usuario === undefined || u1.nombres === undefined || u1.apellidos === undefined || u1.telefono === undefined || u1.direccion === undefined) {
                                alert('Llenar todos los campos');
                            } else {
                                guardar();
                            }
                        };
                    }
        </script>
    </body>


</html>
