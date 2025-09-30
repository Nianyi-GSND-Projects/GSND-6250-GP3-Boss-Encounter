using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class CameraTrigger : MonoBehaviour
{
    private Light[] spotlights;
    
    public UnityEvent OnPlayerEnter;
    
    public static bool isAnyCameraTriggered = false;
    
    public float lightDuration = 10.0f;
    private void Awake()
    {
        spotlights = GetComponentsInChildren<Light>();
        SetSpotlights(false);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player")&& !isAnyCameraTriggered)
        {
            isAnyCameraTriggered = true;
            StartCoroutine(LightActivationSequence());
            OnPlayerEnter.Invoke();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        // if (other.CompareTag("Player"))
        // {
        //     SetSpotlights(false);
        // }
    }

    private IEnumerator LightActivationSequence()
    {
        SetSpotlights(true);
        yield return new WaitForSeconds(lightDuration);
        SetSpotlights(false);
    }
    private void SetSpotlights(bool state)
    {
        if (spotlights != null)
        {
            foreach (Light spot in spotlights)
                {
                spot.enabled = state;
                }
        }
    }

    private void OnDrawGizmos()
    {
        BoxCollider box = GetComponent<BoxCollider>();
        if (box != null)
        {
            Gizmos.color = Color.red;
            Gizmos.matrix = transform.localToWorldMatrix;
            Gizmos.DrawWireCube(box.bounds.center, box.bounds.size);
        }
    }

    public static void ResetTriggerState()
    {
        isAnyCameraTriggered = false;
    }
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
