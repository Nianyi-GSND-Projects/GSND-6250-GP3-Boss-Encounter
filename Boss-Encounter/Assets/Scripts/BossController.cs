using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

[RequireComponent(typeof(NavMeshAgent))]
public class BossController : MonoBehaviour
{
    public Transform player;
    
    private NavMeshAgent agent;
    private float oringinalSpeed;
    void Awake()
    {
        agent = GetComponent<NavMeshAgent>();
        oringinalSpeed = agent.speed;
        if (player == null)
        {
            GameObject go = GameObject.FindWithTag("Player");
            if (go != null)
            {
                player = go.transform;
            }
        }
    }
    
    void Start()
    {
        
    }

    public void ApplySlowdown(float duration,float factor)
    {
        StopCoroutine("SlowdownCoroutine");
        StartCoroutine(SlowdownCoroutine(duration, factor));
    }

    private IEnumerator SlowdownCoroutine(float duration,float factor)
    {
        agent.speed = oringinalSpeed * (1 - factor);
        yield return new WaitForSeconds(duration);
        agent.speed = oringinalSpeed;
    }
    // Update is called once per frame
    void Update()
    {
        if(player)
            {
            agent.SetDestination(player.position);
            }
        else
        {
            
        }
    }
}
