// Swig Interface File
%module "bullet"

%feature("export","1");
%feature("intern_function","bullet-wrap::swig-lispify");
%feature("inline");

// Fix up operator overrides
%rename (assignValue) *::operator =;

%rename (isEqual) *::operator ==;
%rename (isLessThan) *::operator <;
%rename (isGreaterThan) *::operator >;
%rename (isNotMoreThan) *::operator <=;
%rename (isNotLessThan) *::operator >=;
%rename (notEquals) *::operator !=;                         

%rename (add) *::operator +;
%rename (subtract) *::operator -;
%rename (multiply) *::operator *;
%rename (divide) *::operator /;
%rename (modulo) *::operator %;

%rename (increment) *::operator +=;
%rename (decrement) *::operator -=;
%rename (multiplyAndAssign) *::operator *=;
%rename (divideAndAssign) *::operator /=;
%rename (moduloAndAssign) *::operator %=;

%rename (makeCPlusPlusInstance) *::operator new;
%rename (deleteCPlusPlusInstance) *::operator delete;
%rename (makeCPlusArray) *::operator new[];
%rename (deleteCPlusArray) *::operator delete[];


// Ignore pure abstract class constructors

%ignore btMultiSapBroadphase (int, btOverlappingPairCache*);
%ignore btMultiSapBroadphase (int);
%ignore btMultiSapBroadphase ();

// resizeNoInitialize seems friendlier for now
%ignore btAlignedObjectArray< btWheelInfo >::expand ();
%ignore btAlignedObjectArray< btWheelInfo >::resize ();
%ignore btAlignedObjectArray< btWheelInfo >::resize (int);


// Inner Class Work-arounds


///LocalShapeInfo gives extra information for complex shapes
///Currently, only btTriangleMeshShape is available, so it just contains triangleIndex and subpart
struct	LocalShapeInfo
{
  int	m_shapePart;
  int	m_triangleIndex;
		
  //const btCollisionShape*	m_shapeTemp;
  //const btTransform*	m_shapeLocalTransform;
};

struct	LocalRayResult
{
LocalRayResult(const btCollisionObject*	collisionObject, 
               LocalShapeInfo*	localShapeInfo,
               const btVector3&		hitNormalLocal,
               btScalar hitFraction)
:m_collisionObject(collisionObject),
    m_localShapeInfo(localShapeInfo),
    m_hitNormalLocal(hitNormalLocal),
    m_hitFraction(hitFraction)
  {
  }

  const btCollisionObject*		m_collisionObject;
  LocalShapeInfo*			m_localShapeInfo;
  btVector3				m_hitNormalLocal;
  btScalar				m_hitFraction;

};

///RayResultCallback is used to report new raycast results
struct	RayResultCallback
{
  btScalar	m_closestHitFraction;
  const btCollisionObject*		m_collisionObject;
  short int	m_collisionFilterGroup;
  short int	m_collisionFilterMask;
  //@BP Mod - Custom flags, currently used to enable backface culling on tri-meshes, see btRaycastCallback.h. Apply any of the EFlags defined there on m_flags here to invoke.
  unsigned int m_flags;

  virtual ~RayResultCallback();
  bool	hasHit() const;

RayResultCallback()
:m_closestHitFraction(btScalar(1.)),
    m_collisionObject(0),
    m_collisionFilterGroup(btBroadphaseProxy::DefaultFilter),
    m_collisionFilterMask(btBroadphaseProxy::AllFilter),
 //@BP Mod
    m_flags(0)
  {  }

  virtual bool needsCollision(btBroadphaseProxy* proxy0) const
  {
    bool collides = (proxy0->m_collisionFilterGroup & m_collisionFilterMask) != 0;
    collides = collides && (m_collisionFilterGroup & proxy0->m_collisionFilterMask);
    return collides;
  }


  virtual	btScalar	addSingleResult(LocalRayResult& rayResult,bool normalInWorldSpace) = 0;
};

struct	ClosestRayResultCallback : public RayResultCallback
{
 ClosestRayResultCallback(const btVector3&	rayFromWorld,const btVector3&	rayToWorld)
   :m_rayFromWorld(rayFromWorld),
    m_rayToWorld(rayToWorld)
    {
    }

  btVector3	m_rayFromWorld;//used to calculate hitPointWorld from hitFraction
  btVector3	m_rayToWorld;

  btVector3	m_hitNormalWorld;
  btVector3	m_hitPointWorld;
			
  virtual	btScalar	addSingleResult(LocalRayResult& rayResult,bool normalInWorldSpace)
  {
    //caller already does the filter on the m_closestHitFraction
    btAssert(rayResult.m_hitFraction <= m_closestHitFraction);
			
    m_closestHitFraction = rayResult.m_hitFraction;
    m_collisionObject = rayResult.m_collisionObject;
    if (normalInWorldSpace)
      {
        m_hitNormalWorld = rayResult.m_hitNormalLocal;
      } else
      {
        ///need to transform normal into worldspace
        m_hitNormalWorld = m_collisionObject->getWorldTransform().getBasis()*rayResult.m_hitNormalLocal;
      }
    m_hitPointWorld.setInterpolate3(m_rayFromWorld,m_rayToWorld,rayResult.m_hitFraction);
    return rayResult.m_hitFraction;
  }
};

struct	AllHitsRayResultCallback : public RayResultCallback
{
 AllHitsRayResultCallback(const btVector3&	rayFromWorld,const btVector3&	rayToWorld)
   :m_rayFromWorld(rayFromWorld),
    m_rayToWorld(rayToWorld)
    {
    }

  btAlignedObjectArray<const btCollisionObject*>		m_collisionObjects;

  btVector3	m_rayFromWorld;//used to calculate hitPointWorld from hitFraction
  btVector3	m_rayToWorld;

  btAlignedObjectArray<btVector3>	m_hitNormalWorld;
  btAlignedObjectArray<btVector3>	m_hitPointWorld;
  btAlignedObjectArray<btScalar> m_hitFractions;
			
  virtual	btScalar	addSingleResult(LocalRayResult& rayResult,bool normalInWorldSpace)
  {
    m_collisionObject = rayResult.m_collisionObject;
    m_collisionObjects.push_back(rayResult.m_collisionObject);
    btVector3 hitNormalWorld;
    if (normalInWorldSpace)
      {
        hitNormalWorld = rayResult.m_hitNormalLocal;
      } else
      {
        ///need to transform normal into worldspace
        hitNormalWorld = m_collisionObject->getWorldTransform().getBasis()*rayResult.m_hitNormalLocal;
      }
    m_hitNormalWorld.push_back(hitNormalWorld);
    btVector3 hitPointWorld;
    hitPointWorld.setInterpolate3(m_rayFromWorld,m_rayToWorld,rayResult.m_hitFraction);
    m_hitPointWorld.push_back(hitPointWorld);
    m_hitFractions.push_back(rayResult.m_hitFraction);
    return m_closestHitFraction;
  }
};


struct LocalConvexResult
{
LocalConvexResult(const btCollisionObject*	hitCollisionObject, 
                  LocalShapeInfo*	localShapeInfo,
                  const btVector3&		hitNormalLocal,
                  const btVector3&		hitPointLocal,
                  btScalar hitFraction
                  )
:m_hitCollisionObject(hitCollisionObject),
    m_localShapeInfo(localShapeInfo),
    m_hitNormalLocal(hitNormalLocal),
    m_hitPointLocal(hitPointLocal),
    m_hitFraction(hitFraction)
  {
  }

  const btCollisionObject*		m_hitCollisionObject;
  LocalShapeInfo*			m_localShapeInfo;
  btVector3				m_hitNormalLocal;
  btVector3				m_hitPointLocal;
  btScalar				m_hitFraction;
};

///RayResultCallback is used to report new raycast results
struct	ConvexResultCallback
{
  btScalar	m_closestHitFraction;
  short int	m_collisionFilterGroup;
  short int	m_collisionFilterMask;
		
ConvexResultCallback()
:m_closestHitFraction(btScalar(1.)),
    m_collisionFilterGroup(btBroadphaseProxy::DefaultFilter),
    m_collisionFilterMask(btBroadphaseProxy::AllFilter)
  {
  }

  virtual ~ConvexResultCallback()
  {
  }
		
  bool	hasHit() const
  {
    return (m_closestHitFraction < btScalar(1.));
  }

		

  virtual bool needsCollision(btBroadphaseProxy* proxy0) const
  {
    bool collides = (proxy0->m_collisionFilterGroup & m_collisionFilterMask) != 0;
    collides = collides && (m_collisionFilterGroup & proxy0->m_collisionFilterMask);
    return collides;
  }

  virtual	btScalar	addSingleResult(LocalConvexResult& convexResult,bool normalInWorldSpace) = 0;
};

struct	ClosestConvexResultCallback : public ConvexResultCallback
{
 ClosestConvexResultCallback(const btVector3&	convexFromWorld,const btVector3&	convexToWorld)
   :m_convexFromWorld(convexFromWorld),
    m_convexToWorld(convexToWorld),
    m_hitCollisionObject(0)
      {
      }

  btVector3	m_convexFromWorld;//used to calculate hitPointWorld from hitFraction
  btVector3	m_convexToWorld;

  btVector3	m_hitNormalWorld;
  btVector3	m_hitPointWorld;
  const btCollisionObject*	m_hitCollisionObject;
		
  virtual	btScalar	addSingleResult(LocalConvexResult& convexResult,bool normalInWorldSpace)
  {
    //caller already does the filter on the m_closestHitFraction
    btAssert(convexResult.m_hitFraction <= m_closestHitFraction);
						
    m_closestHitFraction = convexResult.m_hitFraction;
    m_hitCollisionObject = convexResult.m_hitCollisionObject;
    if (normalInWorldSpace)
      {
        m_hitNormalWorld = convexResult.m_hitNormalLocal;
      } else
      {
        ///need to transform normal into worldspace
        m_hitNormalWorld = m_hitCollisionObject->getWorldTransform().getBasis()*convexResult.m_hitNormalLocal;
      }
    m_hitPointWorld = convexResult.m_hitPointLocal;
    return convexResult.m_hitFraction;
  }
};

///ContactResultCallback is used to report contact points
struct	ContactResultCallback
{
  short int	m_collisionFilterGroup;
  short int	m_collisionFilterMask;
		
ContactResultCallback()
:m_collisionFilterGroup(btBroadphaseProxy::DefaultFilter),
    m_collisionFilterMask(btBroadphaseProxy::AllFilter)
  {
  }

  virtual ~ContactResultCallback()
  {
  }
		
  virtual bool needsCollision(btBroadphaseProxy* proxy0) const
  {
    bool collides = (proxy0->m_collisionFilterGroup & m_collisionFilterMask) != 0;
    collides = collides && (m_collisionFilterGroup & proxy0->m_collisionFilterMask);
    return collides;
  }

  virtual	btScalar	addSingleResult(btManifoldPoint& cp,	const btCollisionObjectWrapper* colObj0Wrap,int partId0,int index0,const btCollisionObjectWrapper* colObj1Wrap,int partId1,int index1) = 0;
};


%nestedworkaround btCollisionWorld::LocalShapeInfo;
%nestedworkaround btCollisionWorld::LocalRayResult;
%nestedworkaround btCollisionWorld::RayResultCallback;
%nestedworkaround btCollisionWorld::ClosestRayResultCallback;
%nestedworkaround btCollisionWorld::AllHitsRayResultCallback;
%nestedworkaround btCollisionWorld::LocalConvexResult;
%nestedworkaround btCollisionWorld::ConvexResultCallback;
%nestedworkaround btCollisionWorld::ClosestConvexResultCallback;
%nestedworkaround btCollisionWorld::ContactResultCallback;

// Lisp Header

%insert ("lisphead")
%{
(defpackage bullet-physics
  (:use :cl :alexandria)
  (:nicknames bullet)
  (:documentation "Bullet is a Collision Detection and Rigid Body Dynamics
 Library.  The Library is Open Source and free for commercial use, under the
 zlib.  The C++ documentation is at bulletphysics.org; this is a simple
 wrapper to make Bullet available to Common Lisp programs."))

(in-package :bullet-physics)

      %}

// C++ Header
%insert ("header")
%{

#include "btBulletCollisionCommon.h"
#include "btBulletDynamicsCommon.h"


/* We've fooled SWIG into thinking that Inner is a global class, so now we need
 *  to trick the C++ compiler into understanding this apparent global type. */

typedef btCollisionWorld::LocalShapeInfo LocalShapeInfo;
 typedef btCollisionWorld::LocalRayResult LocalRayResult;
 typedef btCollisionWorld::RayResultCallback RayResultCallback;
 typedef btCollisionWorld::ClosestRayResultCallback ClosestRayResultCallback;
 typedef btCollisionWorld::AllHitsRayResultCallback AllHitsRayResultCallback;
 typedef btCollisionWorld::LocalConvexResult LocalConvexResult;
 typedef btCollisionWorld::ConvexResultCallback ConvexResultCallback;
 typedef btCollisionWorld::ClosestConvexResultCallback ClosestConvexResultCallback;
 typedef btCollisionWorld::ContactResultCallback ContactResultCallback;
 %}

%ignore btAlignedAllocator::rebind;

%include "LinearMath/btScalar.h"
%include "LinearMath/btMinMax.h"
%include "LinearMath/btAlignedAllocator.h"
%include "LinearMath/btVector3.h"
%include "LinearMath/btQuaternion.h"
%include "LinearMath/btMatrix3x3.h"
%include "LinearMath/btTransform.h"
%include "LinearMath/btMotionState.h"
%include "LinearMath/btAlignedAllocator.h"
%include "LinearMath/btAlignedObjectArray.h"
%include "BulletCollision/CollisionDispatch/btCollisionWorld.h"
%include "BulletCollision/CollisionDispatch/btCollisionObject.h"
%include "BulletCollision/CollisionShapes/btBoxShape.h"
%include "BulletCollision/CollisionShapes/btSphereShape.h"
%include "BulletCollision/CollisionShapes/btCapsuleShape.h"
%include "BulletCollision/CollisionShapes/btCylinderShape.h"
%include "BulletCollision/CollisionShapes/btConeShape.h"
%include "BulletCollision/CollisionShapes/btStaticPlaneShape.h"
%include "BulletCollision/CollisionShapes/btConvexHullShape.h"
%include "BulletCollision/CollisionShapes/btTriangleMesh.h"
%include "BulletCollision/CollisionShapes/btConvexTriangleMeshShape.h"
%include "BulletCollision/CollisionShapes/btBvhTriangleMeshShape.h"
%include "BulletCollision/CollisionShapes/btScaledBvhTriangleMeshShape.h"
%include "BulletCollision/CollisionShapes/btTriangleMeshShape.h"
%include "BulletCollision/CollisionShapes/btTriangleIndexVertexArray.h"
%include "BulletCollision/CollisionShapes/btCompoundShape.h"
%include "BulletCollision/CollisionShapes/btTetrahedronShape.h"
%include "BulletCollision/CollisionShapes/btEmptyShape.h"
%include "BulletCollision/CollisionShapes/btMultiSphereShape.h"
%include "BulletCollision/CollisionShapes/btUniformScalingShape.h"
%include "BulletCollision/CollisionDispatch/btSphereSphereCollisionAlgorithm.h"
%include "BulletCollision/CollisionDispatch/btDefaultCollisionConfiguration.h"
%include "BulletCollision/CollisionDispatch/btCollisionDispatcher.h"
%include "BulletCollision/BroadphaseCollision/btSimpleBroadphase.h"
%include "BulletCollision/BroadphaseCollision/btAxisSweep3.h"
%include "BulletCollision/BroadphaseCollision/btMultiSapBroadphase.h"
%include "BulletCollision/BroadphaseCollision/btDbvtBroadphase.h"
%include "LinearMath/btQuaternion.h"
%include "LinearMath/btDefaultMotionState.h"
%include "LinearMath/btQuickprof.h"
%include "LinearMath/btIDebugDraw.h"
%include "LinearMath/btSerializer.h"
%include "btBulletCollisionCommon.h" 
%include "BulletDynamics/Dynamics/btDiscreteDynamicsWorld.h"
%include "BulletDynamics/Dynamics/btSimpleDynamicsWorld.h"
%include "BulletDynamics/Dynamics/btRigidBody.h"
%include "BulletDynamics/ConstraintSolver/btTypedConstraint.h"
%include "BulletDynamics/ConstraintSolver/btPoint2PointConstraint.h"
%include "BulletDynamics/ConstraintSolver/btHingeConstraint.h"
%include "BulletDynamics/ConstraintSolver/btConeTwistConstraint.h"
%include "BulletDynamics/ConstraintSolver/btGeneric6DofConstraint.h"
%include "BulletDynamics/ConstraintSolver/btSliderConstraint.h"
%include "BulletDynamics/ConstraintSolver/btGeneric6DofSpringConstraint.h"
%include "BulletDynamics/ConstraintSolver/btUniversalConstraint.h"
%include "BulletDynamics/ConstraintSolver/btHinge2Constraint.h"
%include "BulletDynamics/ConstraintSolver/btGearConstraint.h"
%include "BulletDynamics/ConstraintSolver/btFixedConstraint.h"
%include "BulletDynamics/ConstraintSolver/btSequentialImpulseConstraintSolver.h"
/* %include "BulletDynamics/Vehicle/btWheelInfo.h" */
/* %include "BulletDynamics/Vehicle/btVehicleRaycaster.h" */
/* %include "BulletDynamics/Vehicle/btRaycastVehicle.h" */

/*    // Template instantiations */
/*    %template(alignedWheelInfoArray) btAlignedObjectArray< btWheelInfo >; */


