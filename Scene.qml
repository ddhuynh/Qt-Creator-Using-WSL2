// NOTE:
// Most of the code in this file comes from the Qt Creator documentation. I just made a few adjustments.
// I am not taking credit for any of the code in this file. All credits go to Qt Creator.

import QtQuick
import QtQuick3D
import QtQuick3D.Helpers
import QtQuick3D.Physics

Item {
    // Sets the physics for this world.
    PhysicsWorld
    {
        id: physicsWorld
        running: true
        enableCCD: true
        scene: viewport.scene
        gravity: Qt.vector3d(0, -500, 0)
        typicalLength: 1
        typicalSpeed: 500
        minimumTimestep: 15
        maximumTimestep: 20
    }

    // Sets up a 3d view.
    View3D {
        id: viewport
        anchors.fill: parent

        // Sets the environment colors.
        environment: SceneEnvironment {
            clearColor: "grey"
            backgroundMode: SceneEnvironment.Color
        }

        // Adds a camera to the view.
        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(-200, 100, 500)
            eulerRotation: Qt.vector3d(-20, -20, 0)
            clipFar: 5000
            clipNear: 1
        }

        // Adds some light to the view.
        DirectionalLight {
            eulerRotation.x: -45
            eulerRotation.y: 45
            castsShadow: true
            brightness: 1
            shadowFactor: 50
        }

        // Creates a static baseplate, which is the ground.
        StaticRigidBody {
            position: Qt.vector3d(0, -100, 0)
            eulerRotation: Qt.vector3d(-90, 0, 0)
            collisionShapes: PlaneShape {}
            Model {
                source: "#Rectangle"
                scale: Qt.vector3d(20, 20, 1)
                materials: PrincipledMaterial {
                    baseColor: "green"
                }
                castsShadows: false
                receivesShadows: true
            }
        }

        // Each of these is a cube that is spawned. Yes, this could be better, but I doubt I'll ever revisit qt quick 3d.
        DynamicRigidBody {
            position: Qt.vector3d(-100, 120, 0)
            scale: Qt.vector3d(.25, .25, .25)
            collisionShapes: BoxShape {}
            Model {
                source: "#Cube"
                materials: PrincipledMaterial {
                    baseColor: "red"
                }
            }
        }

        DynamicRigidBody {
            position: Qt.vector3d(-100, 120, 0)
            scale: Qt.vector3d(.25, .25, .25)
            collisionShapes: BoxShape {}
            Model {
                source: "#Cube"
                materials: PrincipledMaterial {
                    baseColor: "orange"
                }
            }
        }

        DynamicRigidBody {
            position: Qt.vector3d(-100, 150, 0)
            scale: Qt.vector3d(.25, .25, .25)
            collisionShapes: BoxShape {}
            Model {
                source: "#Cube"
                materials: PrincipledMaterial {
                    baseColor: "yellow"
                }
            }
        }

        DynamicRigidBody {
            position: Qt.vector3d(-100, 150, 0)
            scale: Qt.vector3d(.25, .25, .25)
            collisionShapes: BoxShape {}
            Model {
                source: "#Cube"
                materials: PrincipledMaterial {
                    baseColor: "lightgreen"
                }
            }
        }

        DynamicRigidBody {
            position: Qt.vector3d(-100, 180, 0)
            scale: Qt.vector3d(.25, .25, .25)
            collisionShapes: BoxShape {}
            Model {
                source: "#Cube"
                materials: PrincipledMaterial {
                    baseColor: "blue"
                }
            }
        }

        DynamicRigidBody {
            position: Qt.vector3d(-100, 180, 0)
            scale: Qt.vector3d(.25, .25, .25)
            collisionShapes: BoxShape {}
            Model {
                source: "#Cube"
                materials: PrincipledMaterial {
                    baseColor: "purple"
                }
            }
        }

        DynamicRigidBody {
            position: Qt.vector3d(-100, 100, 0)
            scale: Qt.vector3d(.25, .25, .25)
            collisionShapes: BoxShape {}
            Model {
                source: "#Cube"
                materials: PrincipledMaterial {
                    baseColor: "pink"
                }
            }
        }

        // Allows the user to control the camera using WASD.
        WasdController
        {
            controlledObject: camera
        }
    }
}
