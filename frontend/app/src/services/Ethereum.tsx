"use client";

import "@rainbow-me/rainbowkit/styles.css";

import type { Address } from "@liquity2/uikit";
import type { ComponentProps, ReactNode } from "react";
import type { Chain } from "wagmi/chains";

import { useDemoMode } from "@/src/demo-mode";
import {
  CHAIN_BLOCK_EXPLORER,
  CHAIN_CONTRACT_ENS_REGISTRY,
  CHAIN_CONTRACT_ENS_RESOLVER,
  CHAIN_CONTRACT_MULTICALL,
  CHAIN_CURRENCY,
  CHAIN_ID,
  CHAIN_NAME,
  CHAIN_RPC_URL,
  WALLET_CONNECT_PROJECT_ID,
} from "@/src/env";
import { noop } from "@/src/utils";
import { useTheme } from "@liquity2/uikit";
import {
  getDefaultConfig,
  lightTheme,
  RainbowKitProvider,
  useAccountModal,
  useConnectModal,
} from "@rainbow-me/rainbowkit";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useMemo } from "react";
import { http, useAccount as useAccountWagmi, useEnsName, WagmiProvider } from "wagmi";

const queryClient = new QueryClient();

export function Ethereum({ children }: { children: ReactNode }) {
  const wagmiConfig = useWagmiConfig();
  const rainbowKitProps = useRainbowKitProps();
  return (
    <WagmiProvider config={wagmiConfig}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitProvider {...rainbowKitProps}>
          {children}
        </RainbowKitProvider>
      </QueryClientProvider>
    </WagmiProvider>
  );
}

export function useAccount():
  & Omit<ReturnType<typeof useAccountWagmi>, "connector">
  & {
    connect: () => void;
    disconnect: () => void;
    ensName: string | undefined;
  }
{
  const demoMode = useDemoMode();
  const account = useAccountWagmi();
  const { openConnectModal } = useConnectModal();
  const { openAccountModal } = useAccountModal();
  const ensName = useEnsName({ address: account?.address });
  return demoMode.enabled ? demoMode.account : {
    ...account,
    connect: account.isConnected && openConnectModal || noop,
    disconnect: account.isConnected && openAccountModal || noop,
    ensName: ensName.data ?? undefined,
  };
}

function useRainbowKitProps(): Omit<ComponentProps<typeof RainbowKitProvider>, "children"> {
  const theme = useTheme();
  return {
    modalSize: "compact",
    theme: lightTheme({
      accentColor: theme.color("accent"),
    }),
  };
}

export function useWagmiConfig() {
  return useMemo(() => {
    const chain = createChain({
      id: CHAIN_ID,
      name: CHAIN_NAME,
      currency: CHAIN_CURRENCY,
      rpcUrl: CHAIN_RPC_URL,
      blockExplorer: CHAIN_BLOCK_EXPLORER,
      contractEnsRegistry: CHAIN_CONTRACT_ENS_REGISTRY,
      contractEnsResolver: CHAIN_CONTRACT_ENS_RESOLVER,
      contractMulticall: CHAIN_CONTRACT_MULTICALL,
    });
    return getDefaultConfig({
      appName: "Liquity v2",
      projectId: WALLET_CONNECT_PROJECT_ID,
      chains: [chain],
      transports: {
        [chain.id]: http(CHAIN_RPC_URL),
      },
      ssr: true,
    });
  }, [
    CHAIN_BLOCK_EXPLORER,
    CHAIN_CONTRACT_ENS_REGISTRY,
    CHAIN_CONTRACT_ENS_RESOLVER,
    CHAIN_CONTRACT_MULTICALL,
    CHAIN_CURRENCY,
    CHAIN_ID,
    CHAIN_NAME,
    CHAIN_RPC_URL,
    WALLET_CONNECT_PROJECT_ID,
  ]);
}

function createChain({
  id,
  name,
  currency,
  rpcUrl,
  blockExplorer,
  contractEnsRegistry,
  contractEnsResolver,
  contractMulticall,
}: {
  id: number;
  name: string;
  currency: { name: string; symbol: string; decimals: number };
  rpcUrl: string;
  blockExplorer?: { name: string; url: string };
  contractEnsRegistry?: { address: Address; block?: number };
  contractEnsResolver?: { address: Address; block?: number };
  contractMulticall?: { address: Address; block?: number };
}): Chain {
  return {
    id,
    name,
    nativeCurrency: currency,
    rpcUrls: {
      default: { http: [rpcUrl] },
    },
    blockExplorers: blockExplorer && {
      default: blockExplorer,
    },
    contracts: {
      ensRegistry: contractEnsRegistry,
      ensUniversalResolver: contractEnsResolver,
      multicall3: contractMulticall,
    },
  } satisfies Chain;
}
