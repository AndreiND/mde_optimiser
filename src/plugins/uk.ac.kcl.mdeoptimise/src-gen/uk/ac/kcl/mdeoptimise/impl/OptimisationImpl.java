/**
 * generated by Xtext 2.14.0
 */
package uk.ac.kcl.mdeoptimise.impl;

import java.util.Collection;

import org.eclipse.emf.common.notify.Notification;
import org.eclipse.emf.common.notify.NotificationChain;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.ENotificationImpl;
import org.eclipse.emf.ecore.impl.MinimalEObjectImpl;

import org.eclipse.emf.ecore.util.EObjectContainmentEList;
import org.eclipse.emf.ecore.util.InternalEList;

import uk.ac.kcl.mdeoptimise.BasePathSpec;
import uk.ac.kcl.mdeoptimise.ConstraintInterpreterSpec;
import uk.ac.kcl.mdeoptimise.EvolverSpec;
import uk.ac.kcl.mdeoptimise.MdeoptimisePackage;
import uk.ac.kcl.mdeoptimise.MetaModelSpec;
import uk.ac.kcl.mdeoptimise.ModelInitialiserSpec;
import uk.ac.kcl.mdeoptimise.ModelPathSpec;
import uk.ac.kcl.mdeoptimise.MultiplicityRefinementSpec;
import uk.ac.kcl.mdeoptimise.ObjectiveInterpreterSpec;
import uk.ac.kcl.mdeoptimise.Optimisation;
import uk.ac.kcl.mdeoptimise.OptimisationSpec;
import uk.ac.kcl.mdeoptimise.ReportInterpreterSpec;
import uk.ac.kcl.mdeoptimise.RulegenSpec;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Optimisation</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * </p>
 * <ul>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getBasepath <em>Basepath</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getMetamodel <em>Metamodel</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getModel <em>Model</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getModelInitialiser <em>Model Initialiser</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getRefinements <em>Refinements</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getObjectives <em>Objectives</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getConstraints <em>Constraints</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getReports <em>Reports</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getEvolvers <em>Evolvers</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getRulegen <em>Rulegen</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.impl.OptimisationImpl#getOptimisation <em>Optimisation</em>}</li>
 * </ul>
 *
 * @generated
 */
public class OptimisationImpl extends MinimalEObjectImpl.Container implements Optimisation
{
  /**
   * The cached value of the '{@link #getBasepath() <em>Basepath</em>}' containment reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getBasepath()
   * @generated
   * @ordered
   */
  protected BasePathSpec basepath;

  /**
   * The cached value of the '{@link #getMetamodel() <em>Metamodel</em>}' containment reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getMetamodel()
   * @generated
   * @ordered
   */
  protected MetaModelSpec metamodel;

  /**
   * The cached value of the '{@link #getModel() <em>Model</em>}' containment reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getModel()
   * @generated
   * @ordered
   */
  protected ModelPathSpec model;

  /**
   * The cached value of the '{@link #getModelInitialiser() <em>Model Initialiser</em>}' containment reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getModelInitialiser()
   * @generated
   * @ordered
   */
  protected ModelInitialiserSpec modelInitialiser;

  /**
   * The cached value of the '{@link #getRefinements() <em>Refinements</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getRefinements()
   * @generated
   * @ordered
   */
  protected EList<MultiplicityRefinementSpec> refinements;

  /**
   * The cached value of the '{@link #getObjectives() <em>Objectives</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getObjectives()
   * @generated
   * @ordered
   */
  protected EList<ObjectiveInterpreterSpec> objectives;

  /**
   * The cached value of the '{@link #getConstraints() <em>Constraints</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getConstraints()
   * @generated
   * @ordered
   */
  protected EList<ConstraintInterpreterSpec> constraints;

  /**
   * The cached value of the '{@link #getReports() <em>Reports</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getReports()
   * @generated
   * @ordered
   */
  protected EList<ReportInterpreterSpec> reports;

  /**
   * The cached value of the '{@link #getEvolvers() <em>Evolvers</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getEvolvers()
   * @generated
   * @ordered
   */
  protected EList<EvolverSpec> evolvers;

  /**
   * The cached value of the '{@link #getRulegen() <em>Rulegen</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getRulegen()
   * @generated
   * @ordered
   */
  protected EList<RulegenSpec> rulegen;

  /**
   * The cached value of the '{@link #getOptimisation() <em>Optimisation</em>}' containment reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getOptimisation()
   * @generated
   * @ordered
   */
  protected OptimisationSpec optimisation;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  protected OptimisationImpl()
  {
    super();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  protected EClass eStaticClass()
  {
    return MdeoptimisePackage.Literals.OPTIMISATION;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public BasePathSpec getBasepath()
  {
    return basepath;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public NotificationChain basicSetBasepath(BasePathSpec newBasepath, NotificationChain msgs)
  {
    BasePathSpec oldBasepath = basepath;
    basepath = newBasepath;
    if (eNotificationRequired())
    {
      ENotificationImpl notification = new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__BASEPATH, oldBasepath, newBasepath);
      if (msgs == null) msgs = notification; else msgs.add(notification);
    }
    return msgs;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setBasepath(BasePathSpec newBasepath)
  {
    if (newBasepath != basepath)
    {
      NotificationChain msgs = null;
      if (basepath != null)
        msgs = ((InternalEObject)basepath).eInverseRemove(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__BASEPATH, null, msgs);
      if (newBasepath != null)
        msgs = ((InternalEObject)newBasepath).eInverseAdd(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__BASEPATH, null, msgs);
      msgs = basicSetBasepath(newBasepath, msgs);
      if (msgs != null) msgs.dispatch();
    }
    else if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__BASEPATH, newBasepath, newBasepath));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public MetaModelSpec getMetamodel()
  {
    return metamodel;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public NotificationChain basicSetMetamodel(MetaModelSpec newMetamodel, NotificationChain msgs)
  {
    MetaModelSpec oldMetamodel = metamodel;
    metamodel = newMetamodel;
    if (eNotificationRequired())
    {
      ENotificationImpl notification = new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__METAMODEL, oldMetamodel, newMetamodel);
      if (msgs == null) msgs = notification; else msgs.add(notification);
    }
    return msgs;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setMetamodel(MetaModelSpec newMetamodel)
  {
    if (newMetamodel != metamodel)
    {
      NotificationChain msgs = null;
      if (metamodel != null)
        msgs = ((InternalEObject)metamodel).eInverseRemove(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__METAMODEL, null, msgs);
      if (newMetamodel != null)
        msgs = ((InternalEObject)newMetamodel).eInverseAdd(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__METAMODEL, null, msgs);
      msgs = basicSetMetamodel(newMetamodel, msgs);
      if (msgs != null) msgs.dispatch();
    }
    else if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__METAMODEL, newMetamodel, newMetamodel));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ModelPathSpec getModel()
  {
    return model;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public NotificationChain basicSetModel(ModelPathSpec newModel, NotificationChain msgs)
  {
    ModelPathSpec oldModel = model;
    model = newModel;
    if (eNotificationRequired())
    {
      ENotificationImpl notification = new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__MODEL, oldModel, newModel);
      if (msgs == null) msgs = notification; else msgs.add(notification);
    }
    return msgs;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setModel(ModelPathSpec newModel)
  {
    if (newModel != model)
    {
      NotificationChain msgs = null;
      if (model != null)
        msgs = ((InternalEObject)model).eInverseRemove(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__MODEL, null, msgs);
      if (newModel != null)
        msgs = ((InternalEObject)newModel).eInverseAdd(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__MODEL, null, msgs);
      msgs = basicSetModel(newModel, msgs);
      if (msgs != null) msgs.dispatch();
    }
    else if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__MODEL, newModel, newModel));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ModelInitialiserSpec getModelInitialiser()
  {
    return modelInitialiser;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public NotificationChain basicSetModelInitialiser(ModelInitialiserSpec newModelInitialiser, NotificationChain msgs)
  {
    ModelInitialiserSpec oldModelInitialiser = modelInitialiser;
    modelInitialiser = newModelInitialiser;
    if (eNotificationRequired())
    {
      ENotificationImpl notification = new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__MODEL_INITIALISER, oldModelInitialiser, newModelInitialiser);
      if (msgs == null) msgs = notification; else msgs.add(notification);
    }
    return msgs;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setModelInitialiser(ModelInitialiserSpec newModelInitialiser)
  {
    if (newModelInitialiser != modelInitialiser)
    {
      NotificationChain msgs = null;
      if (modelInitialiser != null)
        msgs = ((InternalEObject)modelInitialiser).eInverseRemove(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__MODEL_INITIALISER, null, msgs);
      if (newModelInitialiser != null)
        msgs = ((InternalEObject)newModelInitialiser).eInverseAdd(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__MODEL_INITIALISER, null, msgs);
      msgs = basicSetModelInitialiser(newModelInitialiser, msgs);
      if (msgs != null) msgs.dispatch();
    }
    else if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__MODEL_INITIALISER, newModelInitialiser, newModelInitialiser));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<MultiplicityRefinementSpec> getRefinements()
  {
    if (refinements == null)
    {
      refinements = new EObjectContainmentEList<MultiplicityRefinementSpec>(MultiplicityRefinementSpec.class, this, MdeoptimisePackage.OPTIMISATION__REFINEMENTS);
    }
    return refinements;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<ObjectiveInterpreterSpec> getObjectives()
  {
    if (objectives == null)
    {
      objectives = new EObjectContainmentEList<ObjectiveInterpreterSpec>(ObjectiveInterpreterSpec.class, this, MdeoptimisePackage.OPTIMISATION__OBJECTIVES);
    }
    return objectives;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<ConstraintInterpreterSpec> getConstraints()
  {
    if (constraints == null)
    {
      constraints = new EObjectContainmentEList<ConstraintInterpreterSpec>(ConstraintInterpreterSpec.class, this, MdeoptimisePackage.OPTIMISATION__CONSTRAINTS);
    }
    return constraints;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<ReportInterpreterSpec> getReports()
  {
    if (reports == null)
    {
      reports = new EObjectContainmentEList<ReportInterpreterSpec>(ReportInterpreterSpec.class, this, MdeoptimisePackage.OPTIMISATION__REPORTS);
    }
    return reports;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<EvolverSpec> getEvolvers()
  {
    if (evolvers == null)
    {
      evolvers = new EObjectContainmentEList<EvolverSpec>(EvolverSpec.class, this, MdeoptimisePackage.OPTIMISATION__EVOLVERS);
    }
    return evolvers;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<RulegenSpec> getRulegen()
  {
    if (rulegen == null)
    {
      rulegen = new EObjectContainmentEList<RulegenSpec>(RulegenSpec.class, this, MdeoptimisePackage.OPTIMISATION__RULEGEN);
    }
    return rulegen;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public OptimisationSpec getOptimisation()
  {
    return optimisation;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public NotificationChain basicSetOptimisation(OptimisationSpec newOptimisation, NotificationChain msgs)
  {
    OptimisationSpec oldOptimisation = optimisation;
    optimisation = newOptimisation;
    if (eNotificationRequired())
    {
      ENotificationImpl notification = new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__OPTIMISATION, oldOptimisation, newOptimisation);
      if (msgs == null) msgs = notification; else msgs.add(notification);
    }
    return msgs;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setOptimisation(OptimisationSpec newOptimisation)
  {
    if (newOptimisation != optimisation)
    {
      NotificationChain msgs = null;
      if (optimisation != null)
        msgs = ((InternalEObject)optimisation).eInverseRemove(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__OPTIMISATION, null, msgs);
      if (newOptimisation != null)
        msgs = ((InternalEObject)newOptimisation).eInverseAdd(this, EOPPOSITE_FEATURE_BASE - MdeoptimisePackage.OPTIMISATION__OPTIMISATION, null, msgs);
      msgs = basicSetOptimisation(newOptimisation, msgs);
      if (msgs != null) msgs.dispatch();
    }
    else if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, MdeoptimisePackage.OPTIMISATION__OPTIMISATION, newOptimisation, newOptimisation));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public NotificationChain eInverseRemove(InternalEObject otherEnd, int featureID, NotificationChain msgs)
  {
    switch (featureID)
    {
      case MdeoptimisePackage.OPTIMISATION__BASEPATH:
        return basicSetBasepath(null, msgs);
      case MdeoptimisePackage.OPTIMISATION__METAMODEL:
        return basicSetMetamodel(null, msgs);
      case MdeoptimisePackage.OPTIMISATION__MODEL:
        return basicSetModel(null, msgs);
      case MdeoptimisePackage.OPTIMISATION__MODEL_INITIALISER:
        return basicSetModelInitialiser(null, msgs);
      case MdeoptimisePackage.OPTIMISATION__REFINEMENTS:
        return ((InternalEList<?>)getRefinements()).basicRemove(otherEnd, msgs);
      case MdeoptimisePackage.OPTIMISATION__OBJECTIVES:
        return ((InternalEList<?>)getObjectives()).basicRemove(otherEnd, msgs);
      case MdeoptimisePackage.OPTIMISATION__CONSTRAINTS:
        return ((InternalEList<?>)getConstraints()).basicRemove(otherEnd, msgs);
      case MdeoptimisePackage.OPTIMISATION__REPORTS:
        return ((InternalEList<?>)getReports()).basicRemove(otherEnd, msgs);
      case MdeoptimisePackage.OPTIMISATION__EVOLVERS:
        return ((InternalEList<?>)getEvolvers()).basicRemove(otherEnd, msgs);
      case MdeoptimisePackage.OPTIMISATION__RULEGEN:
        return ((InternalEList<?>)getRulegen()).basicRemove(otherEnd, msgs);
      case MdeoptimisePackage.OPTIMISATION__OPTIMISATION:
        return basicSetOptimisation(null, msgs);
    }
    return super.eInverseRemove(otherEnd, featureID, msgs);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Object eGet(int featureID, boolean resolve, boolean coreType)
  {
    switch (featureID)
    {
      case MdeoptimisePackage.OPTIMISATION__BASEPATH:
        return getBasepath();
      case MdeoptimisePackage.OPTIMISATION__METAMODEL:
        return getMetamodel();
      case MdeoptimisePackage.OPTIMISATION__MODEL:
        return getModel();
      case MdeoptimisePackage.OPTIMISATION__MODEL_INITIALISER:
        return getModelInitialiser();
      case MdeoptimisePackage.OPTIMISATION__REFINEMENTS:
        return getRefinements();
      case MdeoptimisePackage.OPTIMISATION__OBJECTIVES:
        return getObjectives();
      case MdeoptimisePackage.OPTIMISATION__CONSTRAINTS:
        return getConstraints();
      case MdeoptimisePackage.OPTIMISATION__REPORTS:
        return getReports();
      case MdeoptimisePackage.OPTIMISATION__EVOLVERS:
        return getEvolvers();
      case MdeoptimisePackage.OPTIMISATION__RULEGEN:
        return getRulegen();
      case MdeoptimisePackage.OPTIMISATION__OPTIMISATION:
        return getOptimisation();
    }
    return super.eGet(featureID, resolve, coreType);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @SuppressWarnings("unchecked")
  @Override
  public void eSet(int featureID, Object newValue)
  {
    switch (featureID)
    {
      case MdeoptimisePackage.OPTIMISATION__BASEPATH:
        setBasepath((BasePathSpec)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__METAMODEL:
        setMetamodel((MetaModelSpec)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__MODEL:
        setModel((ModelPathSpec)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__MODEL_INITIALISER:
        setModelInitialiser((ModelInitialiserSpec)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__REFINEMENTS:
        getRefinements().clear();
        getRefinements().addAll((Collection<? extends MultiplicityRefinementSpec>)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__OBJECTIVES:
        getObjectives().clear();
        getObjectives().addAll((Collection<? extends ObjectiveInterpreterSpec>)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__CONSTRAINTS:
        getConstraints().clear();
        getConstraints().addAll((Collection<? extends ConstraintInterpreterSpec>)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__REPORTS:
        getReports().clear();
        getReports().addAll((Collection<? extends ReportInterpreterSpec>)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__EVOLVERS:
        getEvolvers().clear();
        getEvolvers().addAll((Collection<? extends EvolverSpec>)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__RULEGEN:
        getRulegen().clear();
        getRulegen().addAll((Collection<? extends RulegenSpec>)newValue);
        return;
      case MdeoptimisePackage.OPTIMISATION__OPTIMISATION:
        setOptimisation((OptimisationSpec)newValue);
        return;
    }
    super.eSet(featureID, newValue);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public void eUnset(int featureID)
  {
    switch (featureID)
    {
      case MdeoptimisePackage.OPTIMISATION__BASEPATH:
        setBasepath((BasePathSpec)null);
        return;
      case MdeoptimisePackage.OPTIMISATION__METAMODEL:
        setMetamodel((MetaModelSpec)null);
        return;
      case MdeoptimisePackage.OPTIMISATION__MODEL:
        setModel((ModelPathSpec)null);
        return;
      case MdeoptimisePackage.OPTIMISATION__MODEL_INITIALISER:
        setModelInitialiser((ModelInitialiserSpec)null);
        return;
      case MdeoptimisePackage.OPTIMISATION__REFINEMENTS:
        getRefinements().clear();
        return;
      case MdeoptimisePackage.OPTIMISATION__OBJECTIVES:
        getObjectives().clear();
        return;
      case MdeoptimisePackage.OPTIMISATION__CONSTRAINTS:
        getConstraints().clear();
        return;
      case MdeoptimisePackage.OPTIMISATION__REPORTS:
        getReports().clear();
        return;
      case MdeoptimisePackage.OPTIMISATION__EVOLVERS:
        getEvolvers().clear();
        return;
      case MdeoptimisePackage.OPTIMISATION__RULEGEN:
        getRulegen().clear();
        return;
      case MdeoptimisePackage.OPTIMISATION__OPTIMISATION:
        setOptimisation((OptimisationSpec)null);
        return;
    }
    super.eUnset(featureID);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public boolean eIsSet(int featureID)
  {
    switch (featureID)
    {
      case MdeoptimisePackage.OPTIMISATION__BASEPATH:
        return basepath != null;
      case MdeoptimisePackage.OPTIMISATION__METAMODEL:
        return metamodel != null;
      case MdeoptimisePackage.OPTIMISATION__MODEL:
        return model != null;
      case MdeoptimisePackage.OPTIMISATION__MODEL_INITIALISER:
        return modelInitialiser != null;
      case MdeoptimisePackage.OPTIMISATION__REFINEMENTS:
        return refinements != null && !refinements.isEmpty();
      case MdeoptimisePackage.OPTIMISATION__OBJECTIVES:
        return objectives != null && !objectives.isEmpty();
      case MdeoptimisePackage.OPTIMISATION__CONSTRAINTS:
        return constraints != null && !constraints.isEmpty();
      case MdeoptimisePackage.OPTIMISATION__REPORTS:
        return reports != null && !reports.isEmpty();
      case MdeoptimisePackage.OPTIMISATION__EVOLVERS:
        return evolvers != null && !evolvers.isEmpty();
      case MdeoptimisePackage.OPTIMISATION__RULEGEN:
        return rulegen != null && !rulegen.isEmpty();
      case MdeoptimisePackage.OPTIMISATION__OPTIMISATION:
        return optimisation != null;
    }
    return super.eIsSet(featureID);
  }

} //OptimisationImpl