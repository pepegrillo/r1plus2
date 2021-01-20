//
//  Constants.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//

import UIKit
import Hue

struct Constants {
    
    struct WS {
        static let baseURLAPI = "https://rplus.latmobile.com/"
        static let complementURL = "api/"
        static let complementIMG = "img/"
        
        // ws
        // MARK: GET
        static let getResidencial = "\(baseURLAPI)\(complementURL)residencial"
        static let getAnuncio = "\(baseURLAPI)\(complementURL)anuncios"
        static let getPerfil = "\(baseURLAPI)\(complementURL)user"
        static let getVisitaFrecuente = "\(baseURLAPI)\(complementURL)misvisitas"
        static let getVisitaFrecuenteAll = "\(baseURLAPI)\(complementURL)misvisitas_all"
        static let getProveedor = "\(baseURLAPI)\(complementURL)proveedores"
        static let getProveedorAll = "\(baseURLAPI)\(complementURL)proveedores_all"
        static let getEmpleado = "\(baseURLAPI)\(complementURL)empleados"
        static let getEmpleadoAll = "\(baseURLAPI)\(complementURL)empleados_all"
        static let getEmpleadoDetalle = "\(baseURLAPI)\(complementURL)empleado/"
        static let getAlerta = "\(baseURLAPI)\(complementURL)alertas"
        static let getReporte = "\(baseURLAPI)\(complementURL)reportes"
        static let getDirectorio = "\(baseURLAPI)\(complementURL)directorios"
        static let getMascotas = "\(baseURLAPI)\(complementURL)mascotas_user"
        static let getTipoUsuario = "\(baseURLAPI)\(complementURL)roles"
        static let getTipoResidente = "\(baseURLAPI)\(complementURL)tipo_residentes/"
        static let getTipoSector = "\(baseURLAPI)\(complementURL)tipo_sector_residencial_user"
        static let getUbicacionPorSector = "\(baseURLAPI)\(complementURL)ubicacion_sector/"
        static let getViviendaPorUbicacion = "\(baseURLAPI)\(complementURL)vivienda_ubicacion/"
        static let getAreaComun = "\(baseURLAPI)\(complementURL)areas"
        static let getEmpresaProveedor = "\(baseURLAPI)\(complementURL)empresas"
        static let getTipoDocumento = "\(baseURLAPI)\(complementURL)tipo_documentos"
        static let getHistorialPago = "\(baseURLAPI)\(complementURL)pago/"
        static let getPerfilMascota = "\(baseURLAPI)\(complementURL)mascota/"
        static let getTipoMascota = "\(baseURLAPI)\(complementURL)tipo_mascotas"
        static let getBeneficio = "\(baseURLAPI)\(complementURL)beneficios"
        static let getRestriccion = "\(baseURLAPI)\(complementURL)reglamentos"
        static let getPasesAsignados = "\(baseURLAPI)\(complementURL)pases_asignados"
        
        
        // MARK: POST
        static let postLoginRplus = "\(baseURLAPI)\(complementURL)login"
        static let postLogout = "\(baseURLAPI)\(complementURL)logout"
        static let postRegistro = "\(baseURLAPI)\(complementURL)register"
        static let postVerificarCodigo = "\(baseURLAPI)\(complementURL)verify_code"
        static let postPasswordRecovery = "\(baseURLAPI)\(complementURL)recovery"
        static let postVerificarCodigoWithPassword = "\(baseURLAPI)\(complementURL)verify_code_recovery"
        static let postSetTipoResidente = "\(baseURLAPI)\(complementURL)set_user_residencial"
        static let postAgregarCasa = "\(baseURLAPI)\(complementURL)vivienda_user"
        static let postRegistroEmpleado = "\(baseURLAPI)\(complementURL)empleado"
        static let postRegistroProveedor = "\(baseURLAPI)\(complementURL)proveedor"
        static let postRegistroVisita = "\(baseURLAPI)\(complementURL)pase"
        static let postRegistroMascota = "\(baseURLAPI)\(complementURL)mascota"
        static let postRegistroReporte = "\(baseURLAPI)\(complementURL)reporte"
        static let postAmenidades = "\(baseURLAPI)\(complementURL)reserva"
        
        
        // images
        static let imgResidenciales = "\(baseURLAPI)\(complementIMG)residenciales/"
        static let imgAnuncios = "\(baseURLAPI)\(complementIMG)anuncios/"
        static let img64 = "\(baseURLAPI)\(complementIMG)img64/"
    }
    
    enum HTTPStatusCodes: Int {
        case OK = 200
        case BadRequest = 400
        case Unauthorized = 401
        case Forbidden = 403
        case NotFound = 404
        case InternalServerError = 500
        case NoValidUsername = 5001
    }
    
    enum HTTPMethodType: Int {
        case POST = 0
        case GET = 1
        case DELETE = 2
    }
    
    enum HTTPMethod: String {
        case POST = "POST"
        case GET = "GET"
        case DELETE = "DELETE"
    }
    
    struct PaletteColors {
        // Predefinied Colors
        static let colorPrimary = UIColor(hex: "#7a7a7a") // text color
        static let colorSecondary = UIColor(hex: "#d9d9d9") // background color 898989
        static let aGreen = UIColor(hex: "#55ff57") // background button
        static let aLightGreen = UIColor(hex: "#04cc12") //tag color
        static let aBlue = UIColor(hex: "#0292cc") //tag color
        static let aYellow = UIColor(hex: "#eabd00") //tag color
        static let aPurple = UIColor(hex: "#5e49b0")
        static let aBlueClear = UIColor(red: 8/255, green: 28/255, blue: 36/255, alpha: 0.75)
        static let aLightGray = UIColor(hex: "#F4F4F4")
        static let aGray = UIColor(hex: "#707070")
        static let aBorderGray = UIColor(hex: "#898989")
        static let aWarning = UIColor(hex: "#f9ca24")
        static let aOk = UIColor(hex: "#6ab04c")
        static let aError = UIColor.red
        
        static let rBorderForm = UIColor(hex: "#E5E5E5") // text CCCACA
        static let rButtonBg = UIColor(hex: "#D9D9D9")
        
        static let listBeneficioGray = UIColor(hex: "#B1F5B7")
        static let listBeneficioGreen = UIColor(hex: "#C6C4C4")
        
        static let statusGreen = UIColor(hex: "#00CC13")
        static let statusYellow = UIColor(hex: "#EABD00")
        static let statusBlue = UIColor(hex: "#0092CC")
        
//        static let aBorderGray = UIColor(hex: "#c9c9c9")
    }
    
    struct App {
        
        // PersistanceKey
        static let userData = "userData"
        static let image64Registro = "image64Registro"
        static let saveIdResidencial = "saveIdResidencial"
        
        // Extra App values
        static let cornerRadius = CGFloat(30.0)
        static let cornerRadiusText = CGFloat(24.0)
        static let cornerRadiusTiny = CGFloat(15.0)
        static let cornerRadiusButtonLarge = CGFloat(20.0)
        static let cornerRadiusButton = CGFloat(6.0)
        static let cornerRadiusView = CGFloat(8.0)
        static let cornerCircle = CGFloat(50.0)
        
        // Realm Database Version
        static let bdVersion = 2
        static let bdFacebookData = "bdFacebookData"
        
        //message
        static let logoutMessage = "Tu sesión ha expirado, por favor inicia sesión nuevamente."
        
        //placeholder
        static let imagePlaceholder = "LogoPlaceholder"
        
    }
    
    struct Validations {
        static let checkTerms = "Debes aceptar los términos para realizar el registro"
        static let requiredFieldText = "Campo obligatorio"
        static let requiredMinField = "debe ser un dato válido"
        static let userrplusappMaxError = "La longitud del usuario ingresado es muy corto"
        static let userrplusappMinError = "La longitud del usuario excede los caracteres permitidos"
        static let userrplusappSpaceError = "El usuario no debe contener espacios o caracteres especiales"
        static let passwordRequired = "El campo constraseña es obligatorio"
        static let passwordMaxError = "El campo constraseña debe tener al menos 4 caracteres o más"
        static let passwordSpaceError = "El campo constraseña debe tener más de 4 caracteres, con al menos una letra y un número"
        static let emailInvalidError = "El campo correo electrónico  deber ser un correo válido"
    }
    
    
    struct WebViewsContants {
//        static let resetPassword = "http://appinttestdgii.mh.gob.sv/ssc/securitymob/restablecerPwdTributa/"
    }
}
