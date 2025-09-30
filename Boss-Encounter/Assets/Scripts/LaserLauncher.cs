using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(LineRenderer))]
public class LaserLauncher : MonoBehaviour
{
    // Start is called before the first frame update
    
    [SerializeField]private float maxDistance;
    [SerializeField]private float duration;
    [SerializeField]private float bossSlowDuration;
    [SerializeField]private float bossSlowFactor;
    [SerializeField]private float bossDamage;
    
    private LineRenderer lineRenderer;

    void Awake()
    {
        lineRenderer = GetComponent<LineRenderer>();
        lineRenderer.enabled = false;
    }

    public void Fire()
    {
        Debug.Log("--- FireLaser() method in " + gameObject.name + " was called! ---"); 
        StartCoroutine(FireLaserSequence());
    }

    private IEnumerator FireLaserSequence()
    {
        lineRenderer.enabled = true;
        lineRenderer.SetPosition(0, Vector3.zero);
        RaycastHit hit;
        if (Physics.Raycast(transform.position, transform.forward, out hit, maxDistance))
        {
            lineRenderer.SetPosition(1, new Vector3(0, 0, hit.distance));
            
            BossController boss = hit.collider.gameObject.GetComponent<BossController>();
            if (boss != null)
            {
                boss.ApplySlowdown(bossSlowDuration,bossSlowFactor);
            }
        }
        else
        {
            lineRenderer.SetPosition(1, new Vector3(0, 0, maxDistance));
        }
        yield return new WaitForSeconds(duration);
        lineRenderer.enabled = false;
    }
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
